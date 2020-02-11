//
//  CounterStateMutator.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

internal class CounterStateMutator {
    internal typealias DataStore = CounterDataStore
    internal typealias DataStoreState = DataStore.DataStoreState
    internal typealias DataStoreAction = DataStore.DataStoreAction
    
    private init(){} //Singleton
    
    private static var mutableState: DataStoreState!
    
    internal static func mutate(state: DataStoreState, with action: DataStoreAction) -> DataStoreState {
        mutableState = state
        switch action {
        case let .setCount(count, setBy): setCounterActionMutator(count: count, setBy: setBy)
        case .incrementCount: incrementActionMutator()
        case .changeSecondNestedMetadata: setSecondMetadataMutator()
        case .changeWholeNestedMetadata: nestedMetadataMutator()
        }
        return mutableState
    }

    // MARK: Per-Action Mutators

    private static func setCounterActionMutator(count: Int, setBy: String) {
        mutableState.count = count
        mutableState.lastChangedBy = setBy
    }

    private static func incrementActionMutator() {
        mutableState.count += 1
        mutableState.lastChangedBy = "increment action"
    }

    // MARK: Mutators Used for Testing

    private static func setSecondMetadataMutator() {
        mutableState.nestedMetadata.secondMetadata = 99
    }

    private static func nestedMetadataMutator() {
        mutableState.nestedMetadata = NestedMetadata(firstMetadata: 2, secondMetadata: 2)
    }
}
