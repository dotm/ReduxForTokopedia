//
//  ExampleMiddlewares.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

internal struct LoggingMiddleware: Middleware {
    internal var type = "LoggingMiddleware"
    internal func apply(with action: Action?) -> Action? {
        guard let action = action else {return nil}
        print(Date(), action.type)
        return action
    }
}

internal struct AllowSetToZeroOnly: Middleware {
    internal var type: String = "AllowSetToZeroOnly"
    
    func apply(with action: Action?) -> Action? {
        guard let actionNonOptional = action else {return nil}
        guard let setCounterAction = actionNonOptional as? SetCounterAction else {return actionNonOptional}
        
        if setCounterAction.count == 0 {
            return setCounterAction
        }else{
            print("can only set to 0")
            return nil
        }
    }
}
