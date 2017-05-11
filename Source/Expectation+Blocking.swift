//
//  Expectation+Blocking.swift
//  Pods
//
//  Created by Mostafa Amer on 11.05.17.
//
//

import Nimble
import RxSwift
import RxBlocking

public extension Expectation where T: ObservableType {

    /**
     Expectation with sequence's first element
     
     Transforms the expression by blocking sequence and returns its first element.
    */
    var first: Expectation<T.E> {
        return transform { source in
            try source?.toBlocking().first()
        }
    }
}
