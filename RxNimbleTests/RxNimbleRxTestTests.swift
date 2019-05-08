import Quick
import Nimble
import RxSwift
import RxTest
import RxNimbleRxTest

class RxNimbleRxTestTests: QuickSpec {
    override func spec() {
        describe("Events") {
            let initialClock = 0
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }

            it("works with uncompleted streams") {
                let subject = scheduler.createHotObservable([
                    .next(5, "Hello"),
                    .next(10, "World"),
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
                    .to(equal([
                        .next(5, "Hello"),
                        .next(10, "World")
                        ]))
            }

            it("works with completed streams") {
                let subject = scheduler.createHotObservable([
                    .next(5, "Hello"),
                    .next(10, "World"),
                    .completed(100)
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
                    .to(equal([
                        .next(5, "Hello"),
                        .next(10, "World"),
                        .completed(100)
                        ]))
            }

            it("works with errored streams") {
                let subject: TestableObservable<String> = scheduler.createHotObservable([
                    .error(5, AnyError.any)
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
                    .to(equal([
                        Recorded.error(5, AnyError.any)
                        ]))
            }

            it("throws error if any event is error") {
                let subject = scheduler.createHotObservable([
                    .next(5, "Hello"),
                    .next(10, "World"),
                    .error(15, AnyError.any)
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
                    .to(throwError())
            }

            it("does not throw error if no errors") {
                let subject = scheduler.createHotObservable([
                    .next(5, "Hello"),
                    .next(10, "World")
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
                    .toNot(throwError())
            }

            it("subscribes at specified initial time") {
                let initialTime = 50
                let eventTime = 100
                let subject = scheduler.createColdObservable([
                    .next(eventTime, "Hi")
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag, startAt: initialTime)
                    .to(equal([
                        .next(initialTime + eventTime, "Hi")
                        ]))
            }

            it("ignores hot stream events before initial time") {
                let subject = scheduler.createHotObservable([
                    .next(5, "Hello"),
                    .next(10, "World"),
                    .completed(100)
                    ])

                expect(subject).events(scheduler: scheduler, disposeBag: disposeBag, startAt: 15)
                    .to(equal([
                         .completed(100)
                        ]))
            }
        }
    }
}
