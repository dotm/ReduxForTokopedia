//
//  RootViewModel.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class RootViewModel {
    internal struct Input {
        internal let topSwitchTrigger: Driver<Bool>
        internal let product1SwitchTrigger: Driver<Bool>
        internal let product2SwitchTrigger: Driver<Bool>
    }
    
    internal struct Output {
        internal let topSwitchTrigger: Driver<Bool>
        internal let product1SwitchTrigger: Driver<Bool>
        internal let product2SwitchTrigger: Driver<Bool>
        internal let footerPriceDriver: Driver<String>
    }
    
    internal func transform(input: Input) -> Output {
        let topSwitchAllChildrenTrigger = Driver.combineLatest(
            input.product1SwitchTrigger,
            input.product2SwitchTrigger
        ).map{$0 && $1}
        
        let topSwitchTrigger = Driver.merge(
            input.topSwitchTrigger,
            topSwitchAllChildrenTrigger
        )
        
        let product1SwitchTrigger = Driver.merge(
            input.product1SwitchTrigger,
            input.topSwitchTrigger
        )
        
        let product2SwitchTrigger = Driver.merge(
            input.product2SwitchTrigger,
            input.topSwitchTrigger
        )
        
        let priceDriver = Driver.combineLatest(
            product1SwitchTrigger.map{$0 ? 10000 : 0},
            product2SwitchTrigger.map{$0 ? 8000 : 0}
        ).map { product1, product2 in
            product1 + product2
        }
        let footerPriceDriver = priceDriver.map{"\($0) IDR"}
        
        return Output(
            topSwitchTrigger: topSwitchTrigger,
            product1SwitchTrigger: product1SwitchTrigger,
            product2SwitchTrigger: product2SwitchTrigger,
            footerPriceDriver: footerPriceDriver
        )
    }
}
