//
//  NestedSwitchStateMutator.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

public class NestedSwitchStateMutator: Mutator {
    public typealias DataStoreState = NestedSwitchState
    public typealias DataStoreAction = NestedSwitchAction

    private var mutableState: DataStoreState!

    public func mutate(state: DataStoreState, with action: DataStoreAction) -> DataStoreState {
        mutableState = state
        switch action {
        case .chooseAllProducts: chooseAllProductsActionMutator()
        case .chooseProduct1: chooseProduct1ActionMutator()
        case .chooseProduct2: chooseProduct2ActionMutator()
        case .turnOffAllProducts: turnOffAllProductsActionMutator()
        case .turnOffProduct1: turnOffProduct1ActionMutator()
        case .turnOffProduct2: turnOffProduct2ActionMutator()
        }
        return mutableState
    }

    // MARK: Per-Action Mutators
    private func chooseAllProductsActionMutator() {
        mutableState.topSwitchIsOn = true
        mutableState.product1SwitchIsOn = true
        mutableState.product2SwitchIsOn = true
        mutableState.totalPrice = allProductsPrice
    }

    private func chooseProduct1ActionMutator() {
        mutableState.product1SwitchIsOn = true
        mutableState.topSwitchIsOn = mutableState.product1SwitchIsOn && mutableState.product2SwitchIsOn
        mutableState.totalPrice += product1Price
    }
    
    private func chooseProduct2ActionMutator() {
        mutableState.product2SwitchIsOn = true
        mutableState.topSwitchIsOn = mutableState.product1SwitchIsOn && mutableState.product2SwitchIsOn
        mutableState.totalPrice += product2Price
    }
    
    private func turnOffAllProductsActionMutator() {
        mutableState.topSwitchIsOn = false
        mutableState.product1SwitchIsOn = false
        mutableState.product2SwitchIsOn = false
        mutableState.totalPrice = 0
    }
    
    private func turnOffProduct1ActionMutator() {
        mutableState.topSwitchIsOn = false
        mutableState.product1SwitchIsOn = false
        mutableState.totalPrice -= product1Price
    }
    
    private func turnOffProduct2ActionMutator() {
        mutableState.topSwitchIsOn = false
        mutableState.product2SwitchIsOn = false
        mutableState.totalPrice -= product2Price
    }
}

private let product1Price = 10000
private let product2Price = 8000
private let allProductsPrice = product1Price + product2Price
