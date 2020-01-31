//
//  CounterAction.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

///Empty protocol used to group the actions of one data store
public protocol CounterAction: Action { }

//MARK: IncrementAction
///Example Redux action that uses no data and metadata
public struct IncrementAction: CounterAction {
    //read-only constant that should never be set from init
    public let type: String = "Counter.Increment"
    
    //MARK:Data
    //The data that will be used to modify a store's state object.
    //You don't have to use any data if you don't need to.
    
    //MARK:Metadata
    //Optional data that is used for purposes other than modifying a store's state object (e.g. logging, performance tracking, etc.).
    //You don't have to use any metadata if you don't need to.
}

//MARK: SetCounterAction
///Example Redux action that uses some data and metadata
public struct SetCounterAction: CounterAction {
    //read-only constant that should never be set from init
    public let type: String = "Counter.SetCounter"
    
    //MARK:Data
    //The data that will be used to modify a store's state object.
    public var count: UInt
    
    //MARK:Metadata
    //Optional data that is used for purposes other than modifying a store's state object (e.g. logging, performance tracking, etc.).
    public var setBy: String
}
