//
//  Action.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

//MARK: Action Protocol
/// Redux action used to modify a store's state object.
public protocol Action {
    ///Type name must be a hardcoded constant and must be unique across app (prefix it with your module or data store name)
    var type: String { get /*read-only constant*/ }
    
    //MARK:Data
    //The data that will be used to modify a store's state object.
    //You don't have to use any data if you don't need to.
    
    //MARK:Metadata
    //Optional data that is used for purposes other than modifying a store's state object (e.g. logging, performance tracking, etc.).
    //You don't have to use any metadata if you don't need to.
}
