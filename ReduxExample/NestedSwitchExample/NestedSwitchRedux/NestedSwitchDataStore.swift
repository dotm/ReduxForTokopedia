//
//  NestedSwitchDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift

public class NestedSwitchDataStore: BaseDataStore<NestedSwitchState, NestedSwitchAction, NestedSwitchStateReducer> {
    public override init() { // made public to be accessible from other modules
        let initialState = NestedSwitchState(topSwitchIsOn: false, product1SwitchIsOn: false, product2SwitchIsOn: false)
        super.init(stateRelay: BehaviorRelay(value: initialState), internalState: initialState, reducer: NestedSwitchStateReducer())
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
}
