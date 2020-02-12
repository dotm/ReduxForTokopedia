//
//  BaseDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A base class used to provide default implementation.
/// You should not use this class directly. Use it's children instead.
open class BaseDataStore<DataStoreState, DataStoreAction, DataStoreMutator> where DataStoreAction: Action, DataStoreMutator: Mutator, DataStoreMutator.DataStoreState == DataStoreState, DataStoreMutator.DataStoreAction == DataStoreAction {
    
    /// This init will raise fatal error because this class is not supposed to be instantiated.
    /// If you want to use super.init(), use the other init instead.
    public init(){
        fatalError("You should not use this class outside of this module. Use it's children instead. If you're inheriting this class, make sure you use the other super.init function. Don't use the super.init() with empty argument")
    }
    
    /// Used for super.init call
    public init(stateRelay: BehaviorRelay<DataStoreState>, mutableState: DataStoreState, mutator: DataStoreMutator) {
        self.stateRelay = stateRelay
        self.mutableState = mutableState
        self.mutator = mutator
    }
    
    // MARK: Private Members
    
    // Mutable state can only be modified through the data store's dispatch function
    private var mutableState: DataStoreState
    
    // Access this through DataStore.listenTo(state: keypath)
    private var stateRelay: BehaviorRelay<DataStoreState>
    
    private var mutator: DataStoreMutator
    
    private var middlewares: [Middleware] = []
}

extension BaseDataStore: DataStore {
    // MARK: Public Interface that Conforms to DataStore Protocol
    
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
}

extension BaseDataStore {
    // MARK: Helpers for Dispatch Function
    
    private func applyMiddlewares<DataStoreAction>(with action: DataStoreAction) -> DataStoreAction? where DataStoreAction: Action {
        var nullableAction: Action? = action
        for middleware in middlewares {
            guard let resultAction = middleware.apply(with: nullableAction) as? DataStoreAction else { break }
            nullableAction = resultAction
        }
        //if this function returns nil, the action won't be executed
        return nullableAction as? DataStoreAction
    }
    
    /// Entry-Point for Mutators (functions used to update the data store's state)
    private func mutateState(action: DataStoreAction){
        mutableState = mutator.mutate(state: mutableState, with: action)
    }
    
    private func notifyStateChange() {
        stateRelay.accept(state)
    }
}
