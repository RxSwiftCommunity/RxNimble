import Nimble
import RxSwift
import RxTest

/// A Nimble matcher that succeeds when the actual events are equal to the expected events.
public func equal<T: Equatable>(_ expectedEvents: RecordedEvents<T>) -> Matcher<RecordedEvents<T>> {
    Matcher.define { actualEvents in
        let actualEquatableEvents = try actualEvents.evaluate()?.map { AnyEquatable(target: $0, comparer: ==) }
        let expectedEquatableEvents = expectedEvents.map { AnyEquatable(target: $0, comparer: ==) }

        let matches = (actualEquatableEvents == expectedEquatableEvents)
        return MatcherResult(bool: matches,
                             message: .expectedActualValueTo(
                                "emit <\(stringify(expectedEquatableEvents))>")
        )
    }
}

// Borrowed this implementation from RxTest.
struct AnyEquatable<Target>
: Equatable {
    typealias Comparer = (Target, Target) -> Bool

    let _target: Target
    let _comparer: Comparer

    init(target: Target, comparer: @escaping Comparer) {
        _target = target
        _comparer = comparer
    }
}

func == <T>(lhs: AnyEquatable<T>, rhs: AnyEquatable<T>) -> Bool {
    return lhs._comparer(lhs._target, rhs._target)
}
