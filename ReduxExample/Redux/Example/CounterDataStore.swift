//
//  CounterDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift

///Example Redux data store
public class CounterDataStore: DataStore {
    static var initialState = CounterState(count: 0, lastChangedBy: "init", nestedMetadata: NestedMetadata(firstMetadata: 0, secondMetadata: 0))
    
    var stateSubject: BehaviorSubject<CounterState> = BehaviorSubject(value: CounterDataStore.initialState)
    
    //See DataStore definition for explanation of each method and property
    
    //The dispatch function is implemented in DataStore.swift
    //Mutable state can only be modified through the data store's dispatch function
    private var mutableState = CounterDataStore.initialState
    public var state: CounterState {  //read-only computed property
        return mutableState
    }
    
    internal var middlewares: [Middleware] = [
//        LoggingMiddleware(),
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
    //MARK:Entry-Point for Mutators
    internal func mutateState(action: CounterAction) {
        switch action {
        case let .setCount(count, setBy): setCounterActionMutator(count: count, setBy: setBy)
        case .incrementCount: incrementActionMutator()
        case .changeSecondNestedMetadata: setSecondMetadataMutator()
        case .changeWholeNestedMetadata: nestedMetadataMutator()
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
    
    private func setSecondMetadataMutator(){
        mutableState.nestedMetadata.secondMetadata = 99
    }
    
    private func nestedMetadataMutator(){
        mutableState.nestedMetadata = NestedMetadata(firstMetadata: 2, secondMetadata: 2)
    }
}
