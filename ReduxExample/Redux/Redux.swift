//
//  Redux.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

@propertyWrapper
public struct ReduxState<Type: Equatable> {
    private let relay: BehaviorRelay<Type> //use behavior relay or publish subject?
    private let observable: Observable<Type>
    
    //accessible through: state.value
    public var wrappedValue: Type {
        get { relay.value }
        set { relay.accept(newValue) }
    }
    
    //accessible through: state.$value
    public var projectedValue: (observable: Observable<Type>, distinctObservable: Observable<Type>, currentValue: Type) {
        return (observable, observable.distinctUntilChanged(), relay.value)
    }
    
    public init(wrappedValue: Type)  {
        self.relay = BehaviorRelay(value: wrappedValue)
        self.observable = relay.asObservable()
    }
}

///Example Redux state object
public class CounterState { //use struct or class
    @ReduxState public var count: Int
    @ReduxState public var lastChangedBy: String
    
    internal init(count: Int, lastChangedBy: String) {
        self.count = count
        self.lastChangedBy = lastChangedBy
    }
}

internal protocol DataStore {
    associatedtype DataStoreState
    associatedtype DataStoreAction
    
    //State should not be settable from outside the store
    //and it must not be changed directly (e.g. state = newState) from inside or outside the store
    //it could only be updated through dispatch(action) from inside the store
    var state: DataStoreState { get }
    
    //Public function used to dispatch action from other modules
    func dispatch(action: DataStoreAction)
}

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

internal class Component {
    let disposeBag = DisposeBag()
    init() {
        let store = CounterDataStore()
        print("accessing store state", store.state.count)
        print("accessing store state", store.state.$count.currentValue)
        
        //Subscribe to state change
        store.state.$count.observable.subscribe(onNext: { count in
            print("testcuy count", count)
        }).disposed(by: disposeBag)
        store.state.$lastChangedBy.distinctObservable.subscribe(onNext: { str in
            print("testcuy str", str)
        }).disposed(by: disposeBag)
        
        //Can't set state directly like below
        //  store.state = CounterState(count: 0, lastChangedBy: "tes")
        //Use dispatch instead:
        store.dispatch(action: IncrementAction())
        store.dispatch(action: IncrementAction())
        store.dispatch(action: IncrementAction())
        print(store.state.count)
        store.dispatch(action: SetCounterAction(count: 0, setBy: "admin"))
        print(store.state.count)
    }
}
