//
//  CounterViewController.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 10/02/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class CounterViewController: UIViewController {
    private let store: CounterDataStore
    private let viewModel: CounterViewModel
    private var incrementButton: UIButton!
    private var setCountButton: UIButton!
    private var counterLabel: UILabel!
    
    internal init(){
        store = CounterDataStore()
        viewModel = CounterViewModel(store: store)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
        bindViewModel()
    }
    
    private let disposeBag = DisposeBag()
    private func bindViewModel(){
        let input = CounterViewModel.Input(
            didLoadTrigger: Observable.didLoadTrigger().asDriver(onErrorDriveWith: Driver.empty()),
            incrementTrigger: incrementButton.rx.tap.asDriver(),
            setCountTrigger: setCountButton.rx.tap.map{_ in 0}.asDriver(onErrorDriveWith: Driver.empty()),
            countChanged: store.listenTo(state: \CounterState.count).asDriver(onErrorDriveWith: Driver.empty())
        )
        let output = viewModel.transform(input: input)
        output.dispatchAction.drive(onNext: { [weak self] action in
            self?.store.dispatch(action: action)
        }).disposed(by: disposeBag)
        output.counterTextDriver.drive(onNext: { [weak self] string in
            self?.counterLabel.text = string
        }).disposed(by: disposeBag)
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        
        let incrementButton = UIButton()
        view.addSubview(incrementButton)
        self.incrementButton = incrementButton

        incrementButton.setTitleColor(.blue, for: .normal)
        incrementButton.setTitle("Increment", for: .normal)

        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        incrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        incrementButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        incrementButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let setCountButton = UIButton()
        view.addSubview(setCountButton)
        self.setCountButton = setCountButton
        
        setCountButton.setTitleColor(.blue, for: .normal)
        setCountButton.setTitle("Set Counter to Zero", for: .normal)
        
        setCountButton.translatesAutoresizingMaskIntoConstraints = false
        setCountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setCountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        setCountButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        setCountButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let counterLabel = UILabel()
        view.addSubview(counterLabel)
        self.counterLabel = counterLabel
        
        counterLabel.text = "Counter"
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        counterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
    }
}

extension Observable where E == Void {
    internal static func didLoadTrigger() -> Observable<Void> {
        return Observable.create { observer in
            observer.on(.next(()))
            return Disposables.create()
        }
    }
}
