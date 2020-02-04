//
//  TemplateDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

/* Copy the lines below to use template */
 
//public class <#ModuleName#>DataStore: DataStore {
//    public typealias DataStoreState = <#ModuleName#>State
//    public typealias DataStoreAction = <#ModuleName#>Action
//    
//    public init(){  //made public to be accessible from other modules
//        let initialState = <#ModuleName#>State()
//        stateRelay = BehaviorRelay(value: initialState)
//        mutableState = initialState
//    }
//
//    //Access this through DataStore.observeState.of(property: keypath)
//    internal var stateRelay: BehaviorRelay<DataStoreState>
//
//    //Mutable state can only be modified through the data store's dispatch function
//    private var mutableState: DataStoreState
//    public var state: DataStoreState {  //read-only computed property accessed from other modules
//        return mutableState
//    }
//
//    //Add, remove, and comment out middlewares here
//    internal var middlewares: [Middleware] = []
//
//    //MARK: Custom Store's Properties or Functions
//
//    //You don't have to implement any extra properties or functions if you don't need to
//    //Any custom store function must NOT mutate mutableState
//    //The only functions that are allowed to change mutableState are mutators
//}
//
//extension <#ModuleName#>DataStore {
//    //MARK:Mutators
//    //Mutators must be in the same file as DataStore
//    //  so that mutableState can be private
//
//    //Functions used to update the data store's state
//    //Do NOT do anything here other than updating the mutable state
//    //Any other operation must be done from middleware
//    
//    //MARK:Entry-Point for Mutators
//    internal func mutateState(action: <#ModuleName#>Action) {
//        switch action {
//        //case .example_action_without_argument: perActionMutator()
//        //case let .example_action_with_argument(associatedValue, associatedValue): perActionMutator(arg: associatedValue, arg: associatedValue)
//        //case let .example_action_with_struct_as_argument(data): perActionMutator(arg: data)
//        //case let .example_action_with_dynamic_dictionary_as_argument(metadata): perActionMutator(arg: metadata)
//        }
//    }
//
//    //MARK:Per-Action Mutators
//    private func <#ActionName#>ActionMutator() {
//        //mutate mutableState here
//    }
//
//    private func perActionMutator() {
//        //mutate mutableState here
//    }
//
//    private func perActionMutator(arg: Type, arg: Type) {
//        //mutate mutableState here
//    }
//}
