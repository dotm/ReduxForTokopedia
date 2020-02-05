//
//  DataStoreInternalProtocol.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 04/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A protocol used inside the Redux module
///to provide default implementations
/// for properties and methods used in a data store.
internal protocol DataStoreInternalProtocol {
    associatedtype DataStoreState
    associatedtype DataStoreAction

    // MARK: Default Implementation

    // of the store's properties and methods

    // Used in dispatch after mutableState has been changed
    //  to notify all observer of the store
    //  that the store's state has changed
    func notifyStateChange()

    // Middlewares are applied in dispatch function
    //  before mutateState is called
    //  from left to right (from zero-index of the array to the right)
    func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction?

    // MARK: Required Utilities

    // so that we can implement the default implementation

    // Internal storage of observable state
    /// DO NOT OBSERVE THIS. Observe the store's state using using DataStore.listenTo(state: keypath)
    var stateRelay: BehaviorRelay<DataStoreState> { get }

    func mutateState(action: DataStoreAction)

    var middlewares: [Middleware] { get }

    var state: DataStoreState { get }
}

extension DataStoreInternalProtocol {
    internal func notifyStateChange() {
        stateRelay.accept(state)
    }

    internal func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction? {
        var nullableAction = action as? Action
        for middleware in middlewares {
            guard let resultAction = middleware.apply(with: nullableAction) as? DataStoreAction else { break }
            nullableAction = resultAction as? Action
        }
        guard let resultAction = nullableAction as? DataStoreAction? else { return nil }
        return resultAction
    }
}