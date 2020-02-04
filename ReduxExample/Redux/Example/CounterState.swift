//
//  CounterState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

///Example Redux state object
public struct CounterState: Equatable { //State object must conform to Equatable
    //State must be wrapped with property wrapper
    //  so that it can be accessed as observable.
    //State must be made public to be accessible from other modules.
    public var count: Int
    public var lastChangedBy: String
    
    //Example of nested state (struct inside the state)
    public var nestedMetadata: NestedMetadata
}

public struct NestedMetadata: Equatable {
    public var firstMetadata: Int
    public var secondMetadata: Int
}

//Enable NestedMetadata to be printed
extension NestedMetadata: CustomStringConvertible {
    public var description: String {
        "(\(firstMetadata),\(secondMetadata))"
    }
}
