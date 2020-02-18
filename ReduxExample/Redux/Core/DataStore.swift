//
//  DataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A protocol used to define how other module
/// can interact with a Redux data store.
public protocol DataStore {
    associatedtype DataStoreState
    associatedtype DataStoreAction

    // State should not be settable from outside the store
    // and it must not be changed directly (e.g. state = newState) from inside or outside the store
    // it could only be updated through dispatch(action) from inside the store
    /// Get the current state of the data store
    var state: DataStoreState { get }

    // Public function used to dispatch action from other modules
    /// Change the store's state using this function.
    func dispatch(action: DataStoreAction)

    // Public entry-point to observe the state of the store
    /// Access this using DataStore.listenTo(state: keypath)
    var observeState: Observable<DataStoreState> { get }

    /// Subscribe to changes in data store's state.
    /// Use keypath from the state object to access the state.
    /// For example: listenTo(state: \ExampleState.property.property)
    func listenTo<T: Equatable>(state keyPath: KeyPath<DataStoreState, T>) -> Observable<T>
}

extension DataStore {
    public func listenTo<T: Equatable>(state keyPath: KeyPath<DataStoreState, T>) -> Observable<T> {
        return observeState.of(property: keyPath)
    }
}
