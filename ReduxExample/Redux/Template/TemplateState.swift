//
//  TemplateState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

/* Copy the lines below and then uncomment them to use the template. */

///// Example State
// public struct <#ModuleName#>State: Equatable {
//    // State must conform to Equatable.
//    // State must be made public to be accessible from other modules.
//
//    public var <#stateName1#>: <#StateType1#>
//    public var <#stateName2#>: <#StateType2#>
//
//    // a state can contain another struct (delete this if you don't need this)
//    public var nestedState: ExampleNestedState
//
//    // You can generate init automatically using
//    // - the init generator in Tokopedia XCode extension https://github.com/tokopedia/xcode-helper
//    // - the built-in Xcode generator of memberwise initializer
//    public init(<#stateName1#>: <#StateType1#>, <#stateName2#>: <#StateType2#>, nestedState: ExampleNestedState) {
//        self.<#stateName1#> = <#stateName1#>
//        self.<#stateName2#> = <#stateName2#>
//        self.nestedState = nestedState
//    }
// }
//
///// Example nested state
// public struct ExampleNestedState: Equatable {
//    public var firstProperty: Int = 1
//    public var secondProperty: Int = 2
//
//    // If you don't need to initialize anything
//    // you still need to create an empty init
//    public init() {}
// }
//
//// Make nested state printable from print function.
//// This is optional. You don't have to implement this extension
// extension ExampleNestedState: CustomStringConvertible {
//    public var description: String {
//        "(\(firstProperty),\(secondProperty))"
//    }
// }
