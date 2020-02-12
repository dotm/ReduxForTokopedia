//
//  NesedSwitchAction.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

public enum NestedSwitchAction: Action { // made public to be accessible from other modules
    case chooseAllProducts
    case chooseProduct1
    case chooseProduct2
    case turnOffAllProducts
    case turnOffProduct1
    case turnOffProduct2
}
