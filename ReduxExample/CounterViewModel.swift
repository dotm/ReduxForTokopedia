//
//  CounterViewModel.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 10/02/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

internal class CounterViewModel {
    private let store: CounterDataStore
    init(store: CounterDataStore) {
        self.store = store
    }
    
    internal struct Input {
        internal let didLoadTrigger: Driver<Void>
        internal let incrementTrigger: Driver<Void>
        internal let setCountTrigger: Driver<Int>
        internal let countChanged: Driver<Int>
    }
    
    internal struct Output {
        internal let dispatchAction: Driver<CounterAction>
        internal let counterTextDriver: Driver<String>
    }
    
    internal func transform(input: Input) -> Output {
        let didLoadTrigger = input.didLoadTrigger.map { () -> CounterAction in
            .setCount(count: 0, setBy: "didLoadTrigger")
        }
        let incrementTrigger = input.incrementTrigger.map { () -> CounterAction in
            .incrementCount
        }
        let setCountTrigger = input.setCountTrigger.map { newCount -> CounterAction in
            .setCount(count: newCount, setBy: "setCountTrigger")
        }
        
        let dispatchAction = Driver.merge(
            didLoadTrigger,
            incrementTrigger,
            setCountTrigger
        )
        
        let counterTextDriver = input.countChanged
            .map{_ in "Count: \(self.store.state.count)"}
            .asDriver()
        
        return Output(dispatchAction: dispatchAction, counterTextDriver: counterTextDriver)
    }
}
