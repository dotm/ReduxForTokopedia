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
    func listenTo<T: Equatable>(state keyPath: WritableKeyPath<DataStoreState, T>) -> Observable<T>
}

extension DataStore {
    public func listenTo<T: Equatable>(state keyPath: WritableKeyPath<DataStoreState, T>) -> Observable<T> {
        return observeState.of(property: keyPath)
    }
}


///A base class used to provide default implementation.
///You should not use this class directly. Use it's children instead.
public class BaseDataStore<DataStoreState, DataStoreAction>: DataStore {
    public typealias DataStoreState = DataStoreState
    public typealias DataStoreAction = DataStoreAction
    
    /// This init will raise fatal error because this class is not supposed to be instantiated.
    /// If you want to use super.init(), use the other init instead.
    public init(){
        fatalError("You should not use this class outside of this module. Use it's children instead. If you're inheriting this class, make sure you use the other super.init function. Don't use the super.init() with empty argument")
    }
    
    /// Used for super.init call
    internal init(stateRelay: BehaviorRelay<DataStoreState>, mutableState: DataStoreState){
        self.stateRelay = stateRelay
        self.mutableState = mutableState
    }
    
    // MARK: Private Members
    
    // Mutable state can only be modified through the data store's dispatch function
    internal var mutableState: DataStoreState
    
    // Access this through DataStore.listenTo(state: keypath)
    private var stateRelay: BehaviorRelay<DataStoreState>
    
    private func mutateState(action: DataStoreAction) {}
    
    private var middlewares: [Middleware] = []
}

extension BaseDataStore {
    // MARK: Public Interface
    
    public var state: DataStoreState { // read-only computed property accessed from other modules
        return mutableState
    }
    
    /// Access this through DataStore.listenTo(state: keypath)
    public var observeState: Observable<DataStoreState> {
        stateRelay.asObservable()
    }

    public func dispatch(action: DataStoreAction) {
        guard let action = applyMiddlewares(with: action) else { return }
        mutateState(action: action)
        notifyStateChange()
    }

    private func notifyStateChange() {
        stateRelay.accept(state)
    }

    private func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction? {
        var nullableAction = action as? Action
        for middleware in middlewares {
            guard let resultAction = middleware.apply(with: nullableAction) as? DataStoreAction else { break }
            nullableAction = resultAction as? Action
        }
        guard let resultAction = nullableAction as? DataStoreAction? else { return nil }
        return resultAction
    }
}
