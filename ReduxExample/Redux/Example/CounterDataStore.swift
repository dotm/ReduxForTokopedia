//
//  CounterDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift

/// Example Redux data store
public class CounterDataStore: BaseDataStore<CounterState, CounterAction, CounterStateReducer> {
    public convenience override init() { // made public to be accessible from other modules
        let initialState = CounterState.initialState()
        self.init(initialState: initialState)
    }

    /// You can use this to customize initial state when unit testing
    public init(initialState: CounterState){
        super.init(stateRelay: BehaviorRelay(value: initialState), internalState: initialState, reducer: CounterStateReducer())
    }

    // All the functions defined for the DataStore protocol is implemented in BaseDateStore

    // Add, remove, and comment out middlewares here
    private var middlewares: [Middleware] = [
        // LoggingMiddleware(),
        AllowSetToZeroOnly(),
    ]

    // MARK: Custom Store Properties and Functions

    // You don't have to implement any extra functions if you don't need to
    // Any custom store function must NOT reduce internalState
    // The only functions that are allowed to change internalState are reducers
    public func printValue() {
        print("accessing state here is OK:", state)
        print("mutating state here is NOT OK! Example: internalState = newState")
    }
}
