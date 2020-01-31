//
//  DataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

internal protocol DataStore {
    associatedtype DataStoreState
    associatedtype DataStoreAction
    
    //State should not be settable from outside the store
    //and it must not be changed directly (e.g. state = newState) from inside or outside the store
    //it could only be updated through dispatch(action) from inside the store
    var state: DataStoreState { get }
    
    //Public function used to dispatch action from other modules
    func dispatch(action: DataStoreAction)
    
    func mutateState(action: DataStoreAction)
    
    var middlewares: [Middleware] {get}
    
    func applyMiddlewares(with action: DataStoreAction) -> DataStoreAction?
}

extension DataStore {
    //Public function used to dispatch action from other modules
    //Do NOT change this function
    public func dispatch(action: DataStoreAction){
        //Apply middlewares before mutating state
        guard let action = applyMiddlewares(with: action) else { return }
        
        mutateState(action: action)
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
