//
//  ExampleUsage.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

internal class Component {
    let disposeBag = DisposeBag()
    init() {
        let store = CounterDataStore()
        print("accessing store state", store.state.count)
        print("accessing store state", store.state.$count.currentValue)
        
        //Subscribe to state change
        store.state.$count.observable.subscribe(onNext: { count in
            print("testcuy count", count)
        }).disposed(by: disposeBag)
        store.state.$lastChangedBy.distinctObservable.subscribe(onNext: { str in
            print("testcuy str", str)
        }).disposed(by: disposeBag)
        
        //Can't set state directly like below
        //  store.state = CounterState(count: 0, lastChangedBy: "tes")
        //Use dispatch instead:
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        print(store.state.count)
        store.dispatch(action: .setCount(count: 3, setBy: "admin"))
        store.dispatch(action: .setCount(count: 0, setBy: "admin"))
        print(store.state.count)
    }
}
