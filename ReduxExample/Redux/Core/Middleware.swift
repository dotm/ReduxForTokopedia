//
//  Middleware.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

protocol Middleware {
    var type: String {get}
    func apply(with action: Action?) -> Action?
}
