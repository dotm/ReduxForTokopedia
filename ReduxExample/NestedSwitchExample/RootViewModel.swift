//
//  RootViewModel.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 12/02/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

internal class RootViewModel {
    internal struct Input {
        internal let totalPriceStateChanged: Driver<Int>
    }
    
    internal struct Output {
        internal let footerPriceDriver: Driver<String>
    }
    
    internal func transform(input: Input) -> Output {
        let footerPriceDriver = input.totalPriceStateChanged.map{"\($0) IDR"}
        
        return Output(
            footerPriceDriver: footerPriceDriver
        )
    }
}
