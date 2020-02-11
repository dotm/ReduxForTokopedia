//
//  CounterDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift

/// Example Redux data store
public class CounterDataStore: BaseDataStore<CounterState, CounterAction> {
    // MARK: Custom Store Properties and Functions

    // You don't have to implement any extra functions if you don't need to
    // Any custom store function must NOT mutate mutableState
    // The only functions that are allowed to change mutableState are mutators
    public func printValue() {
        print("accessing state here is OK:", state)
        print("mutating state here is NOT OK! Example: mutableState = newState")
    }

    // MARK: Public Interface

    public override init() { // made public to be accessible from other modules
        let initialState = CounterState(count: 0, lastChangedBy: "init", nestedMetadata: NestedMetadata(firstMetadata: 0, secondMetadata: 0))
        super.init(stateRelay: BehaviorRelay(value: initialState), mutableState: initialState)
    }
    
    // All the functions defined for the DataStore protocol is implemented in BaseDateStore

    // MARK: Middlewares

    // Add, remove, and comment out middlewares here
    private var middlewares: [Middleware] = [
//        LoggingMiddleware(),
        AllowSetToZeroOnly(),
    ]

    // MARK: Mutators

    // Functions used to update the data store's state
    // Do NOT do anything here other than updating the mutable state
    // Any other operation must be done from middleware

    // MARK: Entry-Point for Mutators

    private func mutateState(action: CounterAction) {
        switch action {
        case let .setCount(count, setBy): setCounterActionMutator(count: count, setBy: setBy)
        case .incrementCount: incrementActionMutator()
        case .changeSecondNestedMetadata: setSecondMetadataMutator()
        case .changeWholeNestedMetadata: nestedMetadataMutator()
        }
    }

    // MARK: Per-Action Mutators

    private func setCounterActionMutator(count: Int, setBy: String) {
        mutableState.count = count
        mutableState.lastChangedBy = setBy
    }

    private func incrementActionMutator() {
        mutableState.count += 1
        mutableState.lastChangedBy = "increment action"
    }

    // MARK: Mutators Used for Testing

    private func setSecondMetadataMutator() {
        mutableState.nestedMetadata.secondMetadata = 99
    }

    private func nestedMetadataMutator() {
        mutableState.nestedMetadata = NestedMetadata(firstMetadata: 2, secondMetadata: 2)
    }
}
