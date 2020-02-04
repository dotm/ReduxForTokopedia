//
//  ObservableType+Extensions.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 04/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    public func of<T: Equatable>(property keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map(keyPath: keyPath).distinctUntilChanged()
    }
    public func map<T>(keyPath: WritableKeyPath<E,T>) -> Observable<T> {
        return self.map { $0[keyPath: keyPath] }
    }
}
