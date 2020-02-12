//
//  SwitchViewViewModel.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class SwitchViewViewModel {
    internal struct Input {
        internal let tapTrigger: Driver<Bool>
        internal let stateChangedFromStore: Driver<Bool>
    }
    
    internal struct Output {
        internal let isOnDriver: Driver<Bool>
        internal let notifyStoreOfStateChange: Driver<Bool>
    }
    
    internal func transform(input: Input) -> Output {
        let isOnDriver = Driver.merge(
            input.tapTrigger,
            input.stateChangedFromStore
        )
        
        return Output(
            isOnDriver: isOnDriver,
            notifyStoreOfStateChange: input.tapTrigger
        )
    }
}

