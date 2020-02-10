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
public class CounterDataStore: DataStore {
    public typealias DataStoreState = CounterState
    public typealias DataStoreAction = CounterAction

    // MARK: Public Interface

    public init() { // made public to be accessible from other modules
        let initialState = CounterState(count: 0, lastChangedBy: "init", nestedMetadata: NestedMetadata(firstMetadata: 0, secondMetadata: 0))
        stateRelay = BehaviorRelay(value: initialState)
        mutableState = initialState
    }

    public var state: DataStoreState { // read-only computed property accessed from other modules
        return mutableState
    }

    /// Access this through DataStore.listenTo(state: keypath)
    public var observeState: Observable<DataStoreState> {
        stateRelay.asObservable()
    }

    // MARK: Private Members

    // Access this through DataStore.listenTo(state: keypath)
    private var stateRelay: BehaviorRelay<DataStoreState>

    // Mutable state can only be modified through the data store's dispatch function
    private var mutableState: DataStoreState

    // MARK: Middlewares

    // Add, remove, and comment out middlewares here
    private var middlewares: [Middleware] = [
        LoggingMiddleware(),
        AllowSetToZeroOnly(),
    ]

    // MARK: Custom Store Functions

    // You don't have to implement any extra functions if you don't need to
    // Any custom store function must NOT mutate mutableState
    // The only functions that are allowed to change mutableState are mutators
    public func printValue() {
        print("accessing state here is OK:", state)
        print("mutating state here is NOT OK! Example: mutableState = newState")
    }
}

extension CounterDataStore {
    // MARK: Functions you should NOT touch

    // DO NOT CHANGE THE FUNCTIONS BELOW!
    // They have been implemented in a standardized way.

    public func dispatch(action: DataStoreAction) {
        guard let action = applyMiddlewares(with: action) else { return }
        mutateState(action: action)
        notifyStateChange()
    }

    private func notifyStateChange() {
        stateRelay.accept(state)
    }

    private func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction? {
        var nullableAction: Action? = action
        for middleware in middlewares {
            guard let resultAction = middleware.apply(with: nullableAction) as? DataStoreAction else { break }
            nullableAction = resultAction
        }
        guard let resultAction = nullableAction as? DataStoreAction? else { return nil }
        return resultAction
    }
}

extension CounterDataStore {
    // MARK: Mutators

    // Mutators must be in the same file as DataStore
    //  so that mutableState can be private

    // Functions used to update the data store's state
    // Do NOT do anything here other than updating the mutable state
    // Any other operation must be done from middleware

    // MARK: Entry-Point for Mutators

    internal func mutateState(action: CounterAction) {
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

    // MARK: Used for Testing

    private func setSecondMetadataMutator() {
        mutableState.nestedMetadata.secondMetadata = 99
    }

    private func nestedMetadataMutator() {
        mutableState.nestedMetadata = NestedMetadata(firstMetadata: 2, secondMetadata: 2)
    }
}
