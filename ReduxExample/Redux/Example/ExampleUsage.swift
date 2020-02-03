//
//  ExampleUsage.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 31/01/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift

/*
 To use within production environment:
 
 - initialize data store in topmost parent component and put it in a constant property
 
    ```
    class ShopViewController {
        let store = ShopDataStore()
    }
    ```
 
 - pass store to children of that parent so that the children can dispatch to the data store and subscribe to the data store's state
 
    ```
    class ShopViewController {
        let store = ShopDataStore()
        let childrenComponent: UIView = ChildrenComponent1(store: store)
        let childrenComponent: UIViewController = ChildrenComponent2(store: store)
    }
    ```
 
*/

internal class Component {
    let disposeBag = DisposeBag()
    init() {
        let store = CounterDataStore()
//        print("accessing store state", store.state.count)
//        print("accessing store state", store.state.$count.currentValue)
//
//        //Subscribe to state change
//        store.state.$count.observable.subscribe(onNext: { count in
//            print("testcuy count", count)
//        }).disposed(by: disposeBag)
//        store.state.$lastChangedBy.distinctObservable.subscribe(onNext: { str in
//            print("testcuy str", str)
//        }).disposed(by: disposeBag)
//
//        //Can't set state directly like below
//        //  store.state = CounterState(count: 0, lastChangedBy: "tes")
//        //Use dispatch instead:
//        store.dispatch(action: .incrementCount)
//        store.dispatch(action: .incrementCount)
//        store.dispatch(action: .incrementCount)
//        print(store.state.count)
//        store.dispatch(action: .setCount(count: 3, setBy: "admin"))
//        store.dispatch(action: .setCount(count: 0, setBy: "admin"))
//        print(store.state.count)
        
        
        print("testing nested state -------")
        
//        store.state.$nestedMetadata.observable.subscribe(onNext: { (nestedMetadata) in
//            print( nestedMetadata,
//                "to be able to print this,",
//                "make nestedMetadata printable",
//                "by adding the CustomStringConvertible protocol"
//                )
//        }).disposed(by: disposeBag)
//
//        //test removing whole nestedMetadata first
//        store.state.nestedMetadata.$firstMetadata.observable.subscribe(onNext: { (firstMetadata) in
//            print(firstMetadata)
//        }).disposed(by: disposeBag)
//
//        store.state.nestedMetadata.$secondMetadata.observable.subscribe(onNext: { (secondMetadata) in
//            print("x",secondMetadata)
//        }).disposed(by: disposeBag)
        
        store.dispatch(action: .changeWholeNestedMetadata) //make sure that the subscription above still gets run even if the nested metadata is changed
        
//        store.dispatch(action: .changeSecondNestedMetadata) //should call second metadata only and not first metadata
    }
}
