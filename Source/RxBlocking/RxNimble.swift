import RxSwift
import RxBlocking
import Nimble

// This is handy so we can write expect(o) == 1 instead of expect(o.value) == 1 or whatever.
@available(*, deprecated, message: "use expect(o).first instead")
public func equalFirst<T: Equatable, O: ObservableType>(_ expectedValue: T?) -> Predicate<O> where O.E == T {
    return Predicate.define { actualExpression in
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()

        let matches = (actualValue == expectedValue)
        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

@available(*, deprecated, message: "use expect(o).first instead")
public func equalFirst<T: Equatable>(_ expectedValue: T?) -> Predicate<Variable<T>> {
    return Predicate.define { actualExpression in
        let actualValue = try actualExpression.evaluate()?.value

        let matches = (actualValue == expectedValue) && (expectedValue != nil)
        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

@available(*, deprecated, message: "use expect(o).first instead")
public func equalFirst<T: Equatable, O: ObservableType>(_ expectedValue: T?) -> Predicate<O> where O.E == T? {
    return Predicate.define { actualExpression in
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()

        let matches: Bool
        switch actualValue {
        case .none:
            matches = (expectedValue == nil)
        case .some(let wrapped):
            matches = (wrapped == expectedValue)
        }

        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

@available(*, deprecated, message: "use expect(o).first instead")
public func equalFirst<T: Equatable>(_ expectedValue: T?) -> Predicate<Variable<T?>> {
    return Predicate.define { actualExpression in

        let actualValue = try actualExpression.evaluate()?.value

        let matches: Bool
        switch actualValue {
        case .none:
            matches = (expectedValue == nil)
        case .some(let wrapped):
            matches = (wrapped == expectedValue)
        }

        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

// Applies to Observables of T, which must conform to Equatable.

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable, O: ObservableType>(lhs: Expectation<O>, rhs: T?) where O.E == T {
    lhs.to(equalFirst(rhs))
}

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable>(lhs: Expectation<Variable<T>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable, O: ObservableType>(lhs: Expectation<O>, rhs: T?) where O.E == Optional<T> {
    lhs.to(equalFirst(rhs))
}

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable>(lhs: Expectation<Variable<T?>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable, O: Observable<T>>(lhs: Expectation<O>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

@available(*, deprecated, message: "use expect(o).first instead")
public func ==<T: Equatable, O: Observable<Optional<T>>>(lhs: Expectation<O>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}
