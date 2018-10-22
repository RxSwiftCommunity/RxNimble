import Nimble
import RxSwift
@testable import RxTest

public func equal<T: Equatable>(_ expectedEvents: RecordedEvents<T>) -> Predicate<RecordedEvents<T>> {
    return Predicate.define { actualEvents in
        let actualEquatableEvents = try actualEvents.evaluate()?.map { AnyEquatable(target: $0, comparer: ==) }
        let expectedEquatableEvents = expectedEvents.map { AnyEquatable(target: $0, comparer: ==) }

        let matches = (actualEquatableEvents == expectedEquatableEvents)
        return PredicateResult(bool: matches,
                               message: .expectedActualValueTo(
                                "emit <\(stringify(expectedEquatableEvents))>")
        )
    }
}
