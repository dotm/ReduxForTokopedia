//
//  ReduxState.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

@propertyWrapper
public struct ReduxState<Type: Equatable> {
    private let relay: BehaviorRelay<Type> //use behavior relay or publish subject???
    private let observable: Observable<Type>
    
    //accessible through: state.value
    public var wrappedValue: Type {
        get { relay.value }
        set { relay.accept(newValue) }
    }
    
    //accessible through: state.$value
    public var projectedValue: (observable: Observable<Type>, distinctObservable: Observable<Type>, currentValue: Type) { //observable or asObservable???
        return (observable, observable.distinctUntilChanged(), relay.value)
    }
    
    public init(wrappedValue: Type)  {
        self.relay = BehaviorRelay(value: wrappedValue)
        self.observable = relay.asObservable()
    }
}
