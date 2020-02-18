//
//  NestedSwitchState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

public struct NestedSwitchState: Equatable {
    // State must conform to Equatable.
    // State must be made public to be accessible from other modules.

    public var topSwitchIsOn: Bool
    public var product1SwitchIsOn: Bool
    public var product2SwitchIsOn: Bool
    
    public var totalPrice: Int {
        let product1Price = 10000
        let product2Price = 8000
        var price = 0
        
        if product1SwitchIsOn {
            price += product1Price
        }
        
        if product2SwitchIsOn {
            price += product2Price
        }
        
        return price
    }
}
