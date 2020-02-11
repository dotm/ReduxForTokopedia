//
//  Mutator.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

public protocol Mutator {
    associatedtype DataStoreState
    associatedtype DataStoreAction
    func mutate(state: DataStoreState, with action: DataStoreAction) -> DataStoreState
}
