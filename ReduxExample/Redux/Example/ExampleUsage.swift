//
//  ExampleUsage.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift

// How to use in production environment:
//
// - initialize data store in topmost parent component and put it in a constant property
//
//        ```
//        class ShopViewController {
//            let store = ShopDataStore()
//        }
//        ```
//
// - pass store to children of that parent so that the children
//    can dispatch to the data store and
//    subscribe to the data store's state
//
//        ```
//        class ShopViewController {
//            let store = ShopDataStore()
//            let childrenComponent: UIView = ChildrenComponent1(store: store)
//            let childrenComponent: UIViewController = ChildrenComponent2(store: store)
//        }
//        ```

internal class Component {
    let disposeBag = DisposeBag()
    init() {
        let store = CounterDataStore()
        print("accessing store state:", store.state.count)

        // Subscribe to state change
        store.listenTo(state: \CounterState.count).subscribe(onNext: { count in
            print("count:", count)
        }).disposed(by: disposeBag)
        store.listenTo(state: \CounterState.lastChangedBy).subscribe(onNext: { lastChangedBy in
            print("lastChangedBy", lastChangedBy)
        }).disposed(by: disposeBag)

        // Can't set state directly like below
        //  store.state = CounterState(count: 0, lastChangedBy: "tes")
        // Use dispatch instead:
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .setCount(count: 3, setBy: "admin"))
        store.dispatch(action: .setCount(count: 0, setBy: "admin"))
    }
}
