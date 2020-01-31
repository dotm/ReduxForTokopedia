//
//  CounterAction.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

///Example Redux Action
public enum CounterAction: Action {  //made public to be accessible from other modules
    case incrementCount
    case setCount(count: Int, setBy: String)
}
