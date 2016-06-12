import RxSwift
import RxBlocking
import Nimble

// This is handy so we can write expect(o) == 1 instead of expect(o.value) == 1 or whatever.
public func equalFirst<T: Equatable, O: ObservableType where O.E == T>(expectedValue: T?) -> MatcherFunc<O> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()
        failureMessage.actualValue = "<\(actualValue)>"
        
        let matches = actualValue == expectedValue
        return matches
    }
}

public func equalFirst<T: Equatable>(expectedValue: T?) -> MatcherFunc<Variable<T>> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.value
        failureMessage.actualValue = "<\(actualValue)>"

        let matches = actualValue == expectedValue && expectedValue != nil
        return matches
    }
}

public func equalFirst<T: Equatable, O: ObservableType where O.E == T?>(expectedValue: T?) -> MatcherFunc<O> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()
        failureMessage.actualValue = "<\(actualValue)>"
        
        switch actualValue {
        case .None:
            return expectedValue == nil
        case .Some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

public func equalFirst<T: Equatable>(expectedValue: T?) -> MatcherFunc<Variable<T?>> {
    return MatcherFunc { actualExpression, failureMessage in

        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.value
        failureMessage.actualValue = "<\(actualValue)>"
        
        switch actualValue {
        case .None:
            return expectedValue == nil
        case .Some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

// Applies to Observables of T, which must conform to Equatable.
public func ==<T: Equatable, O: ObservableType where O.E == T>(lhs: Expectation<O>, rhs: T?) {
    lhs.to( equalFirst(rhs) )
}

public func ==<T: Equatable>(lhs: Expectation<Variable<T>>, rhs: T?) {
    lhs.to( equalFirst(rhs) )
}

public func ==<T: Equatable, O: ObservableType where O.E == Optional<T>>(lhs: Expectation<O>, rhs: T?) {
    lhs.to( equalFirst(rhs) )
}

public func ==<T: Equatable>(lhs: Expectation<Variable<T?>>, rhs: T?) {
    lhs.to( equalFirst(rhs) )
}
