import Nimble
import RxSwift
import RxTest

public typealias RecordedEvents<E> = [Recorded<Event<E>>]

public extension Expectation where T: ObservableType {
    func events(scheduler: TestScheduler,
                disposeBag: DisposeBag,
                startAt initialTime: Int = 0) -> Expectation<RecordedEvents<T.E>> {
        return transform { source in
            let results = scheduler.createObserver(T.E.self)

            scheduler.scheduleAt(initialTime) {
                source?.subscribe(results).disposed(by: disposeBag)
            }
            scheduler.start()

            return results.events
        }
    }
}
