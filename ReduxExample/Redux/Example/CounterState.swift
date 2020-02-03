//
//  CounterState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

///Example Redux state object
public class CounterState {
    //State must be wrapped with property wrapper
    //  so that it can be accessed as observable.
    //State must be made public to be accessible from other modules.
    @ReduxState public var count: Int
    @ReduxState public var lastChangedBy: String
    @ReduxState public var nestedMetadata: NestedMetadata
    
    //You can generate this automatically
    //using the Init Generator in Tokopedia XCode helper
    //check https://github.com/tokopedia/xcode-helper
    internal init(count: Int, lastChangedBy: String, nestedMetadata: NestedMetadata) {
        self.count = count
        self.lastChangedBy = lastChangedBy
        self.nestedMetadata = nestedMetadata
    }
}

public class NestedMetadata: Equatable {
    @ReduxState public var firstMetadata: Int
    @ReduxState public var secondMetadata: Int

    public init(firstMetadata: Int, secondMetadata: Int) {
        self.firstMetadata = firstMetadata
        self.secondMetadata = secondMetadata
    }
    
    public static func == (lhs: NestedMetadata, rhs: NestedMetadata) -> Bool {
        return
            lhs.firstMetadata == rhs.firstMetadata &&
            lhs.secondMetadata == rhs.secondMetadata
    }
}
