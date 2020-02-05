//
//  Middleware.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

protocol Middleware {
    func apply(with action: Action?) -> Action?
}

/// Convert generic Action protocol type into a specific enum type that implements the Action protocol
internal func convertType<SpecificActionType>(of action: Action?, to _: SpecificActionType.Type) -> SpecificActionType? {
    guard let actionNonOptional = action else { return nil }
    guard let specificAction = actionNonOptional as? SpecificActionType else {
        // print("action is not the required type")
        return nil
    }

    return specificAction
}
