import RxSwift
import RxBlocking
import Nimble

// This is handy so we can write expect(o) == 1 instead of expect(o.value) == 1 or whatever.
public func equalFirst<T: Equatable, O: ObservableType>(_ expectedValue: T?) -> Predicate<O> where O.E == T {
    return Predicate.define { actualExpression in
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()

        let matches = (actualValue == expectedValue)
        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> Predicate<Variable<T>> {
    return Predicate.define { actualExpression in
        let actualValue = try actualExpression.evaluate()?.value

        let matches = (actualValue == expectedValue) && (expectedValue != nil)
        return PredicateResult(bool: matches,
                               message: .expectedTo("equal <\(String(describing: expectedValue))>"))
    }
}

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

// Double
public func firstBeCloseTo<O: ObservableType>(_ expectedValue: Double, within delta: Double = DefaultDelta) -> Predicate<O> where O.E == Double {
  return Predicate.define(matcher: { (actualExpression) -> PredicateResult in
    let actualValue = try actualExpression.evaluate()?.toBlocking().first()
    let errorMessage = "be close to <\(stringify(expectedValue))> (within \(stringify(delta)))"
    let matches = (actualValue != nil) && (abs(actualValue!.doubleValue - expectedValue.doubleValue) < delta)
    return PredicateResult(bool: matches,
                           message: .expectedCustomValueTo(errorMessage, "<\(stringify(actualValue))>"))
  })
}

public func firstBeCloseTo<O: ObservableType>(_ expectedValue: Double, within delta: Double = DefaultDelta) -> Predicate<O> where O.E == Double? {
  return Predicate.define(matcher: { (actualExpression) -> PredicateResult in
    let actualValue = try actualExpression.evaluate()?.toBlocking().first()
    let errorMessage = "be close to <\(stringify(expectedValue))> (within \(stringify(delta)))"
    let matches: Bool
    switch actualValue {
    case .none:
      matches = false
    case .some(let wrapped):
      matches = (wrapped != nil) && (abs(wrapped!.doubleValue - expectedValue.doubleValue) < delta)
    }
    
    return PredicateResult(bool: matches,
                           message: .expectedCustomValueTo(errorMessage, "<\(stringify(actualValue))>"))
  })
}

infix operator ≈ : ComparisonPrecedence
public func ≈<O: ObservableType>(lhs: Expectation<O>, rhs: Double) where O.E == Double {
  lhs.to(firstBeCloseTo(rhs))
}

public func ≈<O: ObservableType>(lhs: Expectation<O>, rhs: (expected: Double, delta: Double)) where O.E == Double {
  lhs.to(firstBeCloseTo(rhs.expected, within: rhs.delta))
}

public func ≈<O: Observable<Optional<Double>>>(lhs: Expectation<O>, rhs: Double) {
  lhs.to(firstBeCloseTo(rhs))
}

public func ≈<O: Observable<Optional<Double>>>(lhs: Expectation<O>, rhs: (expected: Double, delta: Double)) {
  lhs.to(firstBeCloseTo(rhs.expected, within: rhs.delta))
}

infix operator ± : PlusMinusOperatorPrecedence
public func ±(lhs: Double, rhs: Double) -> (expected: Double, delta: Double) {
  return (expected: lhs, delta: rhs)
}
