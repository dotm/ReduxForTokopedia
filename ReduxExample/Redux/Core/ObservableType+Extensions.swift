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
    public func of<T: Equatable>(property keyPath: KeyPath<E, T>) -> Observable<T> {
        return map(keyPath: keyPath).distinctUntilChanged()
    }

    public func map<T>(keyPath: KeyPath<E, T>) -> Observable<T> {
        return map { $0[keyPath: keyPath] }
    }
}
