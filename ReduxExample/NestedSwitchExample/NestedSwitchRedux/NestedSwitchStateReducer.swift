//
//  NestedSwitchStateReducer.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation

public class NestedSwitchStateReducer: Reducer {
    public typealias DataStoreState = NestedSwitchState
    public typealias DataStoreAction = NestedSwitchAction

    private var internalState: DataStoreState!

    public func reduce(state: DataStoreState, with action: DataStoreAction) -> DataStoreState {
        internalState = state
        switch action {
        case .chooseAllProducts: chooseAllProductsActionReducer()
        case .chooseProduct1: chooseProduct1ActionReducer()
        case .chooseProduct2: chooseProduct2ActionReducer()
        case .turnOffAllProducts: turnOffAllProductsActionReducer()
        case .turnOffProduct1: turnOffProduct1ActionReducer()
        case .turnOffProduct2: turnOffProduct2ActionReducer()
        }
        return internalState
    }

    // MARK: Per-Action Reducers
    private func chooseAllProductsActionReducer() {
        internalState.topSwitchIsOn = true
        internalState.product1SwitchIsOn = true
        internalState.product2SwitchIsOn = true
    }

    private func chooseProduct1ActionReducer() {
        internalState.product1SwitchIsOn = true
        internalState.topSwitchIsOn = internalState.product1SwitchIsOn && internalState.product2SwitchIsOn
    }
    
    private func chooseProduct2ActionReducer() {
        internalState.product2SwitchIsOn = true
        internalState.topSwitchIsOn = internalState.product1SwitchIsOn && internalState.product2SwitchIsOn
    }
    
    private func turnOffAllProductsActionReducer() {
        internalState.topSwitchIsOn = false
        internalState.product1SwitchIsOn = false
        internalState.product2SwitchIsOn = false
    }
    
    private func turnOffProduct1ActionReducer() {
        internalState.topSwitchIsOn = false
        internalState.product1SwitchIsOn = false
    }
    
    private func turnOffProduct2ActionReducer() {
        internalState.topSwitchIsOn = false
        internalState.product2SwitchIsOn = false
    }
}
