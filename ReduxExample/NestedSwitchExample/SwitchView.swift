//
//  SwitchView.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class SwitchView: UIView {
    private var label: UILabel!
    private var switcher: UISwitch!
    
    private let switchedSubject = PublishSubject<Bool>()
    internal var switchedTrigger: Driver<Bool> {
        return switchedSubject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = SwitchViewViewModel()
    internal init(text: String?, backgroundColor: UIColor?, switchTriggerFromParent: Driver<Bool>){
        super.init(frame: CGRect.zero)
        setupUI(text: text, backgroundColor: backgroundColor)
        bindViewModel(switchTriggerFromParent: switchTriggerFromParent)
    }
    
    private func bindViewModel(switchTriggerFromParent: Driver<Bool>){
        let input = SwitchViewViewModel.Input(
            tapTrigger: switcher.rx.isOn.asDriver(),
            switchTriggerFromParent: switchTriggerFromParent
        )
        let output = viewModel.transform(input: input)
        output.isOnDriver.drive(onNext: { (isOn) in
            self.switcher.setOn(isOn, animated: true)
        }).disposed(by: disposeBag)
        output.notifyParent.drive(switchedSubject).disposed(by: disposeBag)
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
