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
        print("accessing store state:", store.state.count)

        //Subscribe to state change
        store.observeState.of(property: \CounterState.count).subscribe(onNext: { count in
            print("count:", count)
        }).disposed(by: disposeBag)
        store.observeState.of(property: \CounterState.lastChangedBy).subscribe(onNext: { lastChangedBy in
            print("lastChangedBy", lastChangedBy)
        }).disposed(by: disposeBag)

        //Can't set state directly like below
        //  store.state = CounterState(count: 0, lastChangedBy: "tes")
        //Use dispatch instead:
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .incrementCount)
        store.dispatch(action: .setCount(count: 3, setBy: "admin"))
        store.dispatch(action: .setCount(count: 0, setBy: "admin"))
        
        testNestedState(store: store)
    }
    
    func testNestedState(store: CounterDataStore){
        print("\ntesting nested state -------\n")
        var nestedMetaDataObserverCalledCount = 0
        var firstMetaDataObserverCalledCount = 0
        var secondMetaDataObserverCalledCount = 0
        
        store.observeState.of(property: \CounterState.nestedMetadata)
            .subscribe(onNext: { (nestedMetadata) in
                nestedMetaDataObserverCalledCount += 1
                print("should be called when children properties is changed", nestedMetadata)
            }).disposed(by: disposeBag)

        //test removing whole nestedMetadata first
        store.observeState.of(property: \CounterState.nestedMetadata.firstMetadata)
            .subscribe(onNext: { (firstMetadata) in
                firstMetaDataObserverCalledCount += 1
                print("should be called twice", firstMetadata)
            }).disposed(by: disposeBag)

        store.observeState.of(property: \CounterState.nestedMetadata.secondMetadata)
            .subscribe(onNext: { (secondMetadata) in
                secondMetaDataObserverCalledCount += 1
                print("should be called multiple times",secondMetadata)
            }).disposed(by: disposeBag)
        
        store.dispatch(action: .changeWholeNestedMetadata) //make sure that the subscription above still gets run even if the nested metadata is changed
        
        store.dispatch(action: .changeSecondNestedMetadata) //should call second metadata only and not first metadata
        
        store.dispatch(action: .changeWholeNestedMetadata)
        store.dispatch(action: .changeSecondNestedMetadata)
        
        let initialChange = 1
        let changedWholeNestedMetadata = 1
        assert(firstMetaDataObserverCalledCount == initialChange + changedWholeNestedMetadata)
        assert(nestedMetaDataObserverCalledCount == secondMetaDataObserverCalledCount)
    }
}
