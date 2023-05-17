import Nimble
import RxSwift
import RxTest

/// A Nimble matcher that succeeds when the actual events emit an error
/// of any type.
public func throwError<T: Equatable>() -> Predicate<RecordedEvents<T>> {
    func extractError(_ recorded: RecordedEvents<T>?) -> [Error]? {
        func extractError<E>(_ recorded: Recorded<Event<E>>) -> Error? {
            return recorded.value.error
        }

        #if swift(>=4.1)
        return recorded?.compactMap(extractError)
        #else
        return recorded?.flatMap(extractError)
        #endif
    }


    return Predicate { actualEvents in
        var actualError: Error?
        do {
            let recordedEvents = try actualEvents.evaluate()
            if let error = extractError(recordedEvents)?.first {
                throw error
            }
        } catch {
            actualError = error
        }

        if let actualError = actualError {
            return PredicateResult(bool: true, message: .expectedCustomValueTo("throw any error", actual: "<\(actualError)>"))
        } else {
            return PredicateResult(bool: false, message: .expectedCustomValueTo("throw any error", actual: "no error"))
        }
    }
}
