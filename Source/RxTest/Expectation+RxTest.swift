import Nimble
import RxSwift
import RxTest

public typealias RecordedEvents<E> = [Recorded<Event<E>>]

public extension Expectation where T: ObservableConvertibleType {
    /// Make an expectation on the events emitted by an observable.
    ///
    /// - Parameters:
    ///   - scheduler: the scheduler used to record events in virtual time units.
    ///   - disposeBag: the dispose bag that will dispose all of its resources between tests.
    ///   - initialTime: the time at which subscription/recording should begin.
    /// - Returns: an expectation of the actual events emitted by the observable.
    func events(scheduler: TestScheduler,
                disposeBag: DisposeBag,
                startAt initialTime: Int = 0) -> Expectation<RecordedEvents<T.Element>> {
        return transform { source in
            let results = scheduler.createObserver(T.Element.self)

            scheduler.scheduleAt(initialTime) {
                source?.asObservable().subscribe(results).disposed(by: disposeBag)
            }
            scheduler.start()

            return results.events
        }
    }
}
