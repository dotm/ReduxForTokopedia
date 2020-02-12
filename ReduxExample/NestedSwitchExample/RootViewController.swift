//
//  RootViewController.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class RootViewController: UIViewController {
    private var topSwitch: SwitchView!
    private var product1Switch: SwitchView!
    private var product2Switch: SwitchView!
    private var footerPriceLabel: UILabel!
    
    private let topSwitchShouldSwitchSubject = PublishSubject<Bool>()
    private var topSwitchShouldSwitchTrigger: Driver<Bool> {
        return topSwitchShouldSwitchSubject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    private let product1ShouldSwitchSubject = PublishSubject<Bool>()
    private var product1ShouldSwitchTrigger: Driver<Bool> {
        return product1ShouldSwitchSubject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    private let product2ShouldSwitchSubject = PublishSubject<Bool>()
    private var product2ShouldSwitchTrigger: Driver<Bool> {
        return product2ShouldSwitchSubject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    private let viewModel = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private let disposeBag = DisposeBag()
    private func bindViewModel(){
        let input = RootViewModel.Input(
            topSwitchTrigger: topSwitch.switchedTrigger,
            product1SwitchTrigger: product1Switch.switchedTrigger,
            product2SwitchTrigger: product2Switch.switchedTrigger
        )
        let output = viewModel.transform(input: input)
        output.topSwitchTrigger.drive(topSwitchShouldSwitchSubject).disposed(by: disposeBag)
        output.product1SwitchTrigger.drive(product1ShouldSwitchSubject).disposed(by: disposeBag)
        output.product2SwitchTrigger.drive(product2ShouldSwitchSubject).disposed(by: disposeBag)
        output.footerPriceDriver.drive(footerPriceLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        setupTopSwitch(topAnchor: view.safeAreaLayoutGuide.topAnchor)
        setupProduct1Switch(topAnchor: topSwitch.bottomAnchor)
        setupProduct2Switch(topAnchor: product1Switch.bottomAnchor)
        setupFooterPriceLabel()
    }
    
    private func setupTopSwitch(topAnchor: NSLayoutYAxisAnchor){
        let view = SwitchView(text: "Pilih semua produk", backgroundColor: .cyan, switchTriggerFromParent: topSwitchShouldSwitchTrigger)
        self.topSwitch = view
        setSwitcherUI(switcher: view, topAnchor: topAnchor)
    }
    
    private func setupProduct1Switch(topAnchor: NSLayoutYAxisAnchor){
        let view = SwitchView(text: "Produk 1", backgroundColor: .lightGray, switchTriggerFromParent: product1ShouldSwitchTrigger)
        self.product1Switch = view
        setSwitcherUI(switcher: view, topAnchor: topAnchor)
    }
    private func setupProduct2Switch(topAnchor: NSLayoutYAxisAnchor){
        let view = SwitchView(text: "Produk 2", backgroundColor: .lightGray, switchTriggerFromParent: product2ShouldSwitchTrigger)
        self.product2Switch = view
        setSwitcherUI(switcher: view, topAnchor: topAnchor)
    }
    
    private func setSwitcherUI(switcher: SwitchView, topAnchor: NSLayoutYAxisAnchor){
        view.addSubview(switcher)
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.topAnchor.constraint(equalTo: topAnchor).isActive = true
        switcher.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        switcher.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        switcher.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupFooterPriceLabel(){
        let footerPriceLabel = UILabel()
        self.footerPriceLabel = footerPriceLabel
        
        footerPriceLabel.text = "0 IDR"
        
        view.addSubview(footerPriceLabel)
        footerPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        footerPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerPriceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
