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
        return mutableState
    }
    
    //Mutable state can only be modified from mutator
    private var mutableState = CounterState(count: 0, lastChangedBy: "init")
    
    //Public function used to dispatch action from other modules
    public func dispatch(action: CounterAction) {
        mutateState(action: action)
    }
    
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
    private func mutateState(action: CounterAction) {
        switch action {
        case let action as SetCounterAction: setCounterActionMutator(action: action)
        //In the above line, we type cast CounterAction to SetCounterAction
            
        //Note that we can also inline the method like below
        //  case let action as SetCounterAction:
        //    return CounterState(count: Int(action.count), lastChangedBy: action.setBy)
        //so that we don't have to define
        //  private func setCounterActionMutator(action: SetCounterAction)
        
        case is IncrementAction: incrementActionMutator()
        //We use `case is IncrementAction` in the line above
        //because using `case let action as IncrementAction:` will cause warning
        //because the action is not used in incrementActionMutator()
        
        default:
            fatalError("Unhandled action: \(action.type)")
        }
    }
    
    //MARK:Per-Action Mutators
    private func setCounterActionMutator(action: SetCounterAction) {
        mutableState.count = Int(action.count)
        mutableState.lastChangedBy = action.setBy
    }
    
    private func incrementActionMutator() {
        mutableState.count += 1
        mutableState.lastChangedBy = "increment action"
    }
}
