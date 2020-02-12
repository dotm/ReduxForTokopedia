//
//  ReduxExampleTests.swift
//  ReduxExampleTests
//
//  Created by Yoshua Elmaryono on 11/02/20.
//  Copyright © 2020 Tokopedia. All rights reserved.
//

import RxCocoa
import RxSwift
import XCTest

@testable import ReduxExample

class ReduxExampleTests: XCTestCase {
    var store = CounterDataStore()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        store = CounterDataStore()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNestedState() {
        let disposeBag = DisposeBag()
        
        var nestedMetaDataObserverCalledCount = 0
        var firstMetaDataObserverCalledCount = 0
        var secondMetaDataObserverCalledCount = 0

        store.listenTo(state: \CounterState.nestedMetadata)
            .subscribe(onNext: { nestedMetadata in
                nestedMetaDataObserverCalledCount += 1
            }).disposed(by: disposeBag)

        //test removing whole nestedMetadata first
        store.listenTo(state: \CounterState.nestedMetadata.firstMetadata)
            .subscribe(onNext: { firstMetadata in
                firstMetaDataObserverCalledCount += 1
            }).disposed(by: disposeBag)

        store.listenTo(state: \CounterState.nestedMetadata.secondMetadata)
            .subscribe(onNext: { secondMetadata in
                secondMetaDataObserverCalledCount += 1
            }).disposed(by: disposeBag)

        store.dispatch(action: .changeWholeNestedMetadata) // make sure that the subscription above still gets run even if the nested metadata is changed

        store.dispatch(action: .changeSecondNestedMetadata) // should call second metadata only and not first metadata

        store.dispatch(action: .changeWholeNestedMetadata)
        store.dispatch(action: .changeSecondNestedMetadata)

        let initialChange = 1
        let changedWholeNestedMetadata = 1
        XCTAssertEqual(firstMetaDataObserverCalledCount, initialChange + changedWholeNestedMetadata)
        XCTAssertEqual(nestedMetaDataObserverCalledCount, secondMetaDataObserverCalledCount)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
