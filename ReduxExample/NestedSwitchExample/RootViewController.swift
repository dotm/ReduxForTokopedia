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
    
    private let viewModel = RootViewModel()
    private let store = NestedSwitchDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private let disposeBag = DisposeBag()
    private func bindViewModel(){
        let input = RootViewModel.Input(totalPriceStateChanged: store.listenTo(state: \NestedSwitchState.totalPrice).asDriver(onErrorDriveWith: Driver.empty()))
        let output = viewModel.transform(input: input)
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
        let view = SwitchView(
            store: store,
            text: "Pilih semua produk",
            backgroundColor: .cyan,
            stateChangedFromStore: store.listenTo(state: \NestedSwitchState.topSwitchIsOn).asDriver(onErrorDriveWith: Driver.empty()),
            isOnAction: .chooseAllProducts,
            isOffAction: .turnOffAllProducts
        )
        self.topSwitch = view
        setSwitcherUI(switcher: view, topAnchor: topAnchor)
    }
    
    private func setupProduct1Switch(topAnchor: NSLayoutYAxisAnchor){
        let view = SwitchView(
            store: store,
            text: "Produk 1",
            backgroundColor: .lightGray,
            stateChangedFromStore: store.listenTo(state: \NestedSwitchState.product1SwitchIsOn).asDriver(onErrorDriveWith: Driver.empty()),
            isOnAction: .chooseProduct1,
            isOffAction: .turnOffProduct1
        )
        self.product1Switch = view
        setSwitcherUI(switcher: view, topAnchor: topAnchor)
    }
    private func setupProduct2Switch(topAnchor: NSLayoutYAxisAnchor){
        let view = SwitchView(
            store: store,
            text: "Produk 2",
            backgroundColor: .lightGray,
            stateChangedFromStore: store.listenTo(state: \NestedSwitchState.product2SwitchIsOn).asDriver(onErrorDriveWith: Driver.empty()),
            isOnAction: .chooseProduct2,
            isOffAction: .turnOffProduct2
        )
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
