//
//  CounterStateReducer.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

public class CounterStateReducer: Reducer {
    public typealias DataStoreState = CounterState
    public typealias DataStoreAction = CounterAction

    private var internalState: DataStoreState!

    public func reduce(state: DataStoreState, with action: DataStoreAction) -> DataStoreState {
        internalState = state
        switch action {
        case let .setCount(count, setBy): setCounterActionReducer(count: count, setBy: setBy)
        case .incrementCount: incrementActionReducer()
        case .changeSecondNestedMetadata: setSecondMetadataReducer()
        case .changeWholeNestedMetadata: nestedMetadataReducer()
        }
        return internalState
    }

    // MARK: Per-Action Reducers

    private func setCounterActionReducer(count: Int, setBy: String) {
        internalState.count = count
        internalState.lastChangedBy = setBy
    }

    private func incrementActionReducer() {
        internalState.count += 1
        internalState.lastChangedBy = "increment action"
    }

    // MARK: Reducers Used for Testing

    private func setSecondMetadataReducer() {
        internalState.nestedMetadata.secondMetadata = 99
    }

    private func nestedMetadataReducer() {
        internalState.nestedMetadata = NestedMetadata(firstMetadata: 2, secondMetadata: 2)
    }
}
