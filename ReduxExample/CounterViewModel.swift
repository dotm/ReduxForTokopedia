//
//  CounterViewModel.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 10/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

internal class CounterViewModel {
    internal struct Input {
        internal let didLoadTrigger: Driver<Void>
        internal let incrementTrigger: Driver<Void>
        internal let setCountTrigger: Driver<Int>
    }
    
    internal struct Output {
        internal let counterTextDriver: Driver<String>
    }
    
    internal func transform(input: Input) -> Output {
        let count = BehaviorRelay<Int>(value: 0)
        
        let didLoadTrigger = input.didLoadTrigger.do(onNext: { () in
            count.accept(0)
        })
        let incrementTrigger = input.incrementTrigger.do(onNext: { () in
            count.accept(count.value + 1)
        })
        let setCountTrigger = input.setCountTrigger.do(onNext: { newCount in
            count.accept(newCount)
        }).map{_ in }
        
        
        let counterTextDriver = Driver.merge(
                didLoadTrigger,
                incrementTrigger,
                setCountTrigger
            )
            .map{"Count: \(count.value)"}
            .asDriver()
        
        return Output(counterTextDriver: counterTextDriver)
    }
}
