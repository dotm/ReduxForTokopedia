//
//  NestedSwitchDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift

public class NestedSwitchDataStore: BaseDataStore<NestedSwitchState, NestedSwitchAction, NestedSwitchStateMutator> {
    public override init() { // made public to be accessible from other modules
        let initialState = NestedSwitchState(topSwitchIsOn: false, product1SwitchIsOn: false, product2SwitchIsOn: false, totalPrice: 0)
        super.init(stateRelay: BehaviorRelay(value: initialState), mutableState: initialState, mutator: NestedSwitchStateMutator())
    }

    // All the functions defined for the DataStore protocol is implemented in BaseDateStore

    // Add, remove, and comment out middlewares here
    private var middlewares: [Middleware] = [
        // LoggingMiddleware(),
        AllowSetToZeroOnly(),
    ]

    // MARK: Custom Store Properties and Functions

    // You don't have to implement any extra functions if you don't need to
    // Any custom store function must NOT mutate mutableState
    // The only functions that are allowed to change mutableState are mutators
    public func printValue() {
        print("accessing state here is OK:", state)
        print("mutating state here is NOT OK! Example: mutableState = newState")
    }
}
