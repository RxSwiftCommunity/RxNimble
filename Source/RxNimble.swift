import RxSwift
import RxBlocking
import Nimble

// This is handy so we can write expect(o) == 1 instead of expect(o.value) == 1 or whatever.
public func equalFirst<T: Equatable, O: ObservableType>(_ expectedValue: T?) -> MatcherFunc<O> where O.E == T {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(String(describing: expectedValue))>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()

        let matches = actualValue == expectedValue
        return matches
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Variable<T>> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(String(describing: expectedValue))>"
        let actualValue = try actualExpression.evaluate()?.value

        let matches = actualValue == expectedValue && expectedValue != nil
        return matches
    }
}

public func equalFirst<T: Equatable, O: ObservableType>(_ expectedValue: T?) -> MatcherFunc<O> where O.E == T? {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(String(describing: expectedValue))>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()

        switch actualValue {
        case .none:
            return expectedValue == nil
        case .some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Variable<T?>> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(String(describing: expectedValue))>"
        let actualValue = try actualExpression.evaluate()?.value

        switch actualValue {
        case .none:
            return expectedValue == nil
        case .some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

// Applies to Observables of T, which must conform to Equatable.
public func ==<T: Equatable, O: ObservableType>(lhs: Expectation<O>, rhs: T?) where O.E == T {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable>(lhs: Expectation<Variable<T>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable, O: ObservableType>(lhs: Expectation<O>, rhs: T?) where O.E == Optional<T> {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable>(lhs: Expectation<Variable<T?>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable, O: Observable<T>>(lhs: Expectation<O>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable, O: Observable<Optional<T>>>(lhs: Expectation<O>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}
