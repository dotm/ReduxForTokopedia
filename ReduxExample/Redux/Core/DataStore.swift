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

internal protocol DataStore {
    associatedtype DataStoreState
    associatedtype DataStoreAction
    
    static var initialState: DataStoreState {get}
    
    //State should not be settable from outside the store
    //and it must not be changed directly (e.g. state = newState) from inside or outside the store
    //it could only be updated through dispatch(action) from inside the store
    var state: DataStoreState { get }
    
    //Public function used to dispatch action from other modules
    //Dispatch will apply middleware to the action
    //  and then execute mutateState to mutate the data store's state
    ///Change the store's state using this function.        
    ///DO NOT IMPLEMENT THIS FUNCTION. It has been implemented in a standardized way in the DataStore.swift file.
    func dispatch(action: DataStoreAction)
    
    //Main entry-point for mutators
    //You must implement this yourself in your data store
    func mutateState(action: DataStoreAction)
    
    //Public entry-point to observe the state of the store
    ///Access this using DataStore.observeState.of(property: keypath)
    var observeState: Observable<DataStoreState> {get}
    
    //Internal storage of observable state
    ///DO NOT OBSERVE THIS. Observe the store's state using using DataStore.observeState.of(property: keypath)
    var stateSubject: BehaviorSubject<DataStoreState> {get}
    
    //Used in dispatch after mutableState has been changed
    //  to notify all observer of the store
    //  that the store's state has changed
    func notifyStateChange()
    
    //Middlewares are applied
    //  before mutateState is called
    //  from left to right (from zero-index of the array to the right)
    //See the default implementation in the DataStore extension below
    //  for details on how they are applied
    var middlewares: [Middleware] {get}
    func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction?
}

extension DataStore {
    public var observeState: Observable<DataStoreState> {
        stateSubject.asObservable()
    }
    
    //Public function used to dispatch action from other modules
    //Do NOT change this function
    public func dispatch(action: DataStoreAction){
        //Apply middlewares before mutating state
        guard let action = applyMiddlewares(with: action) else { return }
        
        mutateState(action: action)
        notifyStateChange()
    }
    
    internal func notifyStateChange(){
        stateSubject.onNext(state)
    }
    
    internal func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction? {
        var nullableAction = action as? Action
        for middleware in middlewares {
            guard let resultAction = middleware.apply(with: nullableAction) as? DataStoreAction else {break}
            nullableAction = resultAction as? Action
        }
        guard let resultAction = nullableAction as? DataStoreAction? else {return nil}
        return resultAction
    }
}

extension ObservableType {
    public func of<T: Equatable>(property keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map(keyPath: keyPath).distinctUntilChanged()
    }
    public func map<T>(keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map { $0[keyPath: keyPath] }
    }
}
