//
//  CounterState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

///Example Redux state object
public class CounterState {
    @ReduxState public var count: Int
    @ReduxState public var lastChangedBy: String
    
    //You can generate this automatically
    //using the Init Generator in Tokopedia XCode helper
    //check https://github.com/tokopedia/xcode-helper
    internal init(count: Int, lastChangedBy: String) {
        self.count = count
        self.lastChangedBy = lastChangedBy
    }
}
