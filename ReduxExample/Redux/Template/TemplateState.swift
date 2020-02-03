//
//  TemplateState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

/* Copy the lines below to use template */

//public class <#ModuleName#>State {
//    //created as a class so that state.$property.observable run properly
//    //if we use struct, the observable will only be called the first time only
//
//    //State must be wrapped with property wrapper
//    //  so that it can be accessed as observable.
//    //State must be made public to be accessible from other modules.
//    @ReduxState public var <#stateName1#>: <#stateType1#>
//    @ReduxState public var <#stateName2#>: <#stateType2#>
//    //a state can contain another state (delete this if you don't have nested state)
//    @ReduxState public var nestedState: ExampleNestedState
//
//    //You can generate this automatically
//    //using the newest Init Generator in Tokopedia XCode helper
//    //check https://github.com/tokopedia/xcode-helper
//    internal init(<#stateName1#>: <#stateType1#>, <#stateName2#>: <#stateType2#>, nestedState: ExampleNestedState) {
//        self.<#stateName1#> = <#stateName1#>
//        self.<#stateName2#> = <#stateName2#>
//        self.nestedState = nestedState
//    }
//}
//
//public class ExampleNestedState: Equatable { //nested state must conform to equatable
//    public static func == (lhs: NestedMetadata, rhs: NestedMetadata) -> Bool {
//        return
//            lhs.firstProperty == rhs.firstProperty &&
//            lhs.secondProperty == rhs.secondProperty
//    }
//
//    @ReduxState public var firstProperty: Int
//    @ReduxState public var secondProperty: Int
//
//    public init(firstProperty: Int, secondProperty: Int) {
//        self.firstProperty = firstProperty
//        self.secondProperty = secondProperty
//    }
//}
