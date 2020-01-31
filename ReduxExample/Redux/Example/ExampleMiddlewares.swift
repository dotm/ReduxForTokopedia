//
//  ExampleMiddlewares.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

internal struct LoggingMiddleware: Middleware {
    func apply<Action>(with action: Action?) -> Action? {
        guard let action = action else {return nil}
        print(Date(), action)
        return action
    }
}

internal struct AllowSetToZeroOnly: Middleware {
    func apply(with action: Action?) -> Action? {
        guard let specificAction = convertType(of: action, to: CounterAction.self) else {return action}
        
        //convert to specific case of enum
        guard case .setCount(let count, _) = specificAction else {return specificAction}

        //MARK: Middleware implementation
        if count == 0 {
            return specificAction
        }else{
            print("can only set to 0")
            return nil //stop action propagation
        }
    }
}
