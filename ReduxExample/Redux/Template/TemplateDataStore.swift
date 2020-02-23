//
//  TemplateDataStore.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

/* Copy the lines below and then uncomment them to use the template. */

//import RxCocoa
//import RxSwift
//
///// Data store for <#ModuleName#>
//public class <#ModuleName#>DataStore: BaseDataStore<<#ModuleName#>State, <#ModuleName#>Action, <#ModuleName#>StateReducer> {
//
//    // MARK: Public Interface
//
//    public override init() { // made public to be accessible from other modules
//        let initialState = <#ModuleName#>State.initialState()
//        super.init(stateRelay: BehaviorRelay(value: initialState), internalState: initialState, reducer: <#ModuleName#>StateReducer())
//    }
//
//    // All the functions defined for the DataStore protocol is implemented in BaseDateStore
//
//    // Add, remove, and comment out middlewares here
//    private var middlewares: [Middleware] = []
//
//    // MARK: Custom Store's Properties or Functions
//
//    // You don't have to implement any extra properties or functions if you don't need to
//    // Any custom store function must NOT reduce internalState
//    // The only functions that are allowed to change internalState are reducers
//}
