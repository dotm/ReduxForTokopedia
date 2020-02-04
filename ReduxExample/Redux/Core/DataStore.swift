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
    
    //State should not be settable from outside the store
    //and it must not be changed directly (e.g. state = newState) from inside or outside the store
    //it could only be updated through dispatch(action) from inside the store
    var state: DataStoreState { get }
    
    //Public function used to dispatch action from other modules
    //Dispatch will apply middleware to the action
    //  and then execute mutateState to mutate the data store's state
    func dispatch(action: DataStoreAction)
    
    //Main entry-point for mutators
    //You must implement this yourself in your data store
    func mutateState(action: DataStoreAction)
    
    //Middlewares are applied
    //  before mutateState is called
    //  from left to right (from zero-index of the array to the right)
    //See the default implementation in the DataStore extension below
    //  for details on how they are applied
    var middlewares: [Middleware] {get}
    func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction?
    
    var stateSubject: BehaviorSubject<DataStoreState> {get}
    var observeState: Observable<DataStoreState> {get}
    func notifyStateChange()
    
    static var initialState: DataStoreState {get}
}

extension DataStore {
    //Public function used to dispatch action from other modules
    //Do NOT change this function
    public func dispatch(action: DataStoreAction){
        //Apply middlewares before mutating state
        guard let action = applyMiddlewares(with: action) else { return }
        
        mutateState(action: action)
        notifyStateChange()
    }
    
    var observeState: Observable<DataStoreState> {
        stateSubject.asObservable()
    }
    func notifyStateChange(){
        stateSubject.onNext(state)
    }
    
    func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction? {
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
    func of<T: Equatable>(property keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map(keyPath: keyPath).distinctUntilChanged()
    }
    func map<T>(keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map { $0[keyPath: keyPath] }
    }
}
