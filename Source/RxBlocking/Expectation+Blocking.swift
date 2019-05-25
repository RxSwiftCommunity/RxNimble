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

public extension Expectation where T: ObservableConvertibleType {

    /**
     Expectation with sequence's first element
     
     Transforms the expression by blocking sequence and returns its first element.
    */
    var first: Expectation<T.Element> {
        return transform { source in
            try source?.toBlocking().first()
        }
    }
    /**
     Expectation with sequence's last element

     Transforms the expression by blocking sequence and returns its last element.
     */
    var last: Expectation<T.Element> {
        return transform { source in
            try source?.toBlocking().last()
        }
    }

    /**
     Expectation with all sequence's elements

     Transforms the expression by blocking sequence and returns its elements.
     */
    var array: Expectation<[T.Element]> {
        return transform { source in
            try source?.toBlocking().toArray()
        }
    }
}
