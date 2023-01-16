//
//  Expectation+Blocking.swift
//  Pods
//
//  Created by Mostafa Amer on 11.05.17.
//
//

import Foundation
import Nimble
import RxSwift
import RxBlocking

public extension SyncExpectation where Value: ObservableConvertibleType {

    // MARK: - first

    /// Expectation with sequence's first element
    ///
    /// Transforms the expression by blocking sequence and returns its first element.
    /// - parameter timeout: Maximal time interval waiting for first element to emit before throwing error
    func first(timeout: TimeInterval? = nil) -> SyncExpectation<Value.Element> {
        return transform { source in
            try source?.toBlocking(timeout: timeout).first()
        }
    }

    /// Expectation with sequence's first element
    ///
    /// Transforms the expression by blocking sequence and returns its first element.
    var first: SyncExpectation<Value.Element> {
        return first()
    }

    // MARK: - last

    /// Expectation with sequence's last element
    ///
    /// Transforms the expression by blocking sequence and returns its last element.
    /// - parameter timeout: Maximal time interval waiting for sequence to complete before throwing error
    func last(timeout: TimeInterval? = nil) -> SyncExpectation<Value.Element> {
        return transform { source in
            try source?.toBlocking(timeout: timeout).last()
        }
    }

    /// Expectation with sequence's last element
    ///
    /// Transforms the expression by blocking sequence and returns its last element.
    var last: SyncExpectation<Value.Element> {
        return last()
    }

    // MARK: - array

    /// Expectation with all sequence's elements
    ///
    /// Transforms the expression by blocking sequence and returns its elements.
    /// - parameter timeout: Maximal time interval waiting for sequence to complete before throwing error
    func array(timeout: TimeInterval? = nil) -> SyncExpectation<[Value.Element]> {
        return transform { source in
            try source?.toBlocking(timeout: timeout).toArray()
        }
    }

    /// Expectation with all sequence's elements
    ///
    /// Transforms the expression by blocking sequence and returns its elements.
    var array: SyncExpectation<[Value.Element]> {
        return array()
    }
}
