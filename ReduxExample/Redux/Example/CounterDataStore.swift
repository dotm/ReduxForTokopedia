//
//  CounterDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

///Example Redux data store
public class CounterDataStore: DataStore {
    //State should not be updated from outside the store
    //and it must not be changed directly from inside or outside (e.g. state = newState)
    //it could only be updated through dispatch(action) from inside the store
    public var state: CounterState {
        //read-only computed property
        return mutableState
    }
    
    //Mutable state can only be modified from mutator
    private var mutableState = CounterState(count: 0, lastChangedBy: "init")
    
    internal var middlewares: [Middleware] = [
        LoggingMiddleware(),
        AllowSetToZeroOnly()
    ]
    
    //MARK: Custom Store Functions
    //You don't have to implement any extra functions if you don't need to
    //Any custom store function must NOT mutate mutableState
    //The only functions that are allowed to change mutableState are mutators
    public func printValue(){
        print("accessing state here is OK:", state)
        print("mutating state here is NOT OK! Example: state = newState")
    }
}

//MARK:Mutators
//Functions used to update the data store's state
//Do NOT do anything here other than updating the mutable state
//Any other operation must be done from middleware
extension CounterDataStore {
    //MARK:Main Mutator
    internal func mutateState(action: CounterAction) {
        action.test()
        switch action {
        case let .setCount(count, setBy): setCounterActionMutator(count: count, setBy: setBy)
        case .incrementCount: incrementActionMutator()
        }
    }
    
    //MARK:Per-Action Mutators
    private func setCounterActionMutator(count: Int, setBy: String) {
        mutableState.count = count
        mutableState.lastChangedBy = setBy
    }
    
    private func incrementActionMutator() {
        mutableState.count += 1
        mutableState.lastChangedBy = "increment action"
    }
}
