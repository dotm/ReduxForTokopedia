//
//  Redux.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

///Example Redux state object
public struct CounterState {
    public let count: Int
    public let lastChangedBy: String
}

protocol DataStore {
    associatedtype DataStoreState
    associatedtype DataStoreAction
    
    //State should not be settable from outside the store
    //and it must not be changed directly (e.g. state = newState) from inside or outside the store
    //it could only be updated through dispatch(action) from inside the store
    var currentState: DataStoreState { get }
    
    //Public function used to dispatch action from other modules
    func dispatch(action: DataStoreAction)
    
    //Pure function used to update the data store's action
    func reducer(action: DataStoreAction) -> DataStoreState
}

///Example Redux data store
public class CounterDataStore: DataStore {
    //State should not be updated from outside the store
    //and it must not be changed directly from inside or outside (e.g. state = newState)
    //it could only be updated through dispatch(action) from inside the store
    public private(set) var currentState = CounterState(count: 0, lastChangedBy: "init")
    
    //Public function used to dispatch action from other modules
    public func dispatch(action: CounterAction) {
        currentState = reducer(action: action)
    }
}

//MARK:Reducers
extension CounterDataStore {
    //Pure function used to update the data store's action
    //MARK:Main Reducer
    internal func reducer(action: CounterAction) -> CounterState {
        switch action {
        case let action as SetCounterAction: return setCounterActionReducer(action: action)
        //In the above line, we type cast CounterAction to SetCounterAction
            
        //Note that we can also inline the method like below
        //  case let action as SetCounterAction:
        //    return CounterState(count: Int(action.count), lastChangedBy: action.setBy)
        //so that we don't have to define
        //  private func setCounterActionReducer(action: SetCounterAction) -> CounterState
        
        case is IncrementAction: return incrementActionReducer()
        //We use `case is IncrementAction` in the line above
        //because using `case let action as IncrementAction:` will cause warning
        //because the action is not used in incrementActionReducer()
        
        default:
            fatalError("Unhandled action: \(action.type)")
        }
    }
    
    //MARK:Action Reducers
    private func setCounterActionReducer(action: SetCounterAction) -> CounterState {
        return CounterState(count: Int(action.count), lastChangedBy: action.setBy)
    }
    
    private func incrementActionReducer() -> CounterState {
        return CounterState(count: currentState.count + 1, lastChangedBy: "increment action")
    }
    
    Registers listeners via subscribe(listener);
    Handles unregistering of listeners via the function returned by subscribe(listener).
}

internal class Component {
    init() {
        let store = CounterDataStore()
        let accessingStoreState = store.currentState.count
        print(accessingStoreState)
        
        //Can't set state directly
        //  store.currentState = CounterState(count: 0, lastChangedBy: "tes")
        //Use dispatch instead:
        store.dispatch(action: IncrementAction())
        print(store.currentState.count)
        store.dispatch(action: SetCounterAction(count: 0, setBy: "admin"))
        print(store.currentState.count)
        
        //let countDriver = store.subscribeToState(currentState.count).dispose(by: disposeBag)
    }
}
