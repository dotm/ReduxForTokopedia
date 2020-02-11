//
//  CounterStateMutator.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

public class CounterStateMutator: Mutator {
    public typealias DataStoreState = CounterState
    public typealias DataStoreAction = CounterAction
    
    private var mutableState: DataStoreState!
    
    public func mutate(state: DataStoreState, with action: DataStoreAction) -> DataStoreState {
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
