//
//  <#ModuleName#>Middleware.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

/* Copy the lines below to use template */

//// To stop the propagation of action
//// (stopping it from mutating the data store's state),
//// return nil from a middleware
//
////Redux middleware that can be used by any action
// internal struct <#MiddlewareName#>Middleware: Middleware {
//    func apply<Action>(with action: Action?) -> Action? {
//        guard let action = action else {return nil}
//
//        //MARK: Middleware implementation
//        //implement your middleware here
//
//        return action //or return nil to stop action propagation
//    }
// }
//
/////Example Redux middleware that can be used by a specific action
// internal struct AllowSetToZeroOnly: Middleware {
//    func apply(with action: Action?) -> Action? {
//        guard let specificAction = convertType(of: action, to: <#ModuleName#>Action.self) else {return action}
//
//        //convert to specific case of <#ModuleName#>Action enum
//        guard case .example_action_with_argument(let associatedValue, let associatedValue) = specificAction else {return specificAction}
//
//        //MARK: Middleware implementation
//        //implement your middleware here
//        //the arguments from the associatedValue will be accessible here
//
//        return action //or return nil to stop action propagation
//    }
// }
