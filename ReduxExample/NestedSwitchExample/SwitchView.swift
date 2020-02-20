//
//  SwitchView.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class SwitchView: UIView {
    private var label: UILabel!
    private var switcher: UISwitch!
    
    private let store: NestedSwitchDataStore
    
    private let disposeBag = DisposeBag()
    private let viewModel = SwitchViewViewModel()
    internal init(store: NestedSwitchDataStore, text: String?, backgroundColor: UIColor?, stateChangedFromStore: Driver<Bool>, isOnAction: NestedSwitchAction, isOffAction: NestedSwitchAction){
        self.store = store
        super.init(frame: CGRect.zero)
        setupUI(text: text, backgroundColor: backgroundColor)
        bindViewModel(stateChangedFromStore: stateChangedFromStore, isOnAction: isOnAction, isOffAction: isOffAction)
    }
    
    private func bindViewModel(stateChangedFromStore: Driver<Bool>, isOnAction: NestedSwitchAction, isOffAction: NestedSwitchAction){
        let input = SwitchViewViewModel.Input(
            tapTrigger: switcher.rx.isOn.asDriver(),
            stateChangedFromStore: stateChangedFromStore
        )
        let output = viewModel.transform(input: input)
        output.isOnDriver.drive(onNext: { [weak self] isOn in
            self?.switcher.setOn(isOn, animated: true)
        }).disposed(by: disposeBag)
        output.notifyStoreOfStateChange.drive(onNext: { [weak self] isOn in
            let action = isOn ? isOnAction : isOffAction
            self?.store.dispatch(action: action)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String?, backgroundColor: UIColor?){
        self.backgroundColor = backgroundColor
        
        let label = UILabel()
        addSubview(label)
        self.label = label
        
        label.text = text
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let switcher = UISwitch()
        addSubview(switcher)
        self.switcher = switcher
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        switcher.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
