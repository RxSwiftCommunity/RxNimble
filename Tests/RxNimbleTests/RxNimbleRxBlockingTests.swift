import Quick
import Nimble
import RxSwift
import RxNimble

class RxNimbleRxBlockingTests: QuickSpec {
    override func spec() {

        // MARK: First

        describe("First") {
            it("works with plain observables") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("Hi")

                expect(subject).first == "Hi"
            }

            it("only checks the first value") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("Hi")
                subject.onNext("Hello")

                expect(subject).first == "Hi"
            }

            it("can use different matchers") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("")

                expect(subject).first.to(beEmpty())
            }

            it("get first error") {
                let subject = ReplaySubject<Any>.createUnbounded()
                subject.onError(AnyError.any)

                expect(subject).first.to(throwError())
            }

            it("fails if first value is not being emitted in time") {
                let subject = ReplaySubject<Any>.createUnbounded()

                // Never push onNext

                expect(subject).first(timeout: 1).to(throwError(RxError.timeout))
            }
        }

        // MARK: Last

        describe("Last") {
            it("checks for last element") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("Hello")
                subject.onNext("World")
                subject.onCompleted()

                expect(subject).last == "World"
            }

            it("is nil, if sequence is empty") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onCompleted()

                expect(subject).last.to(beNil())
            }

            it("error, if terminated with error") {
                let subject = ReplaySubject<Any>.createUnbounded()
                subject.onNext("Hello, world!")
                subject.onError(AnyError.any)

                expect(subject).last.to(throwError())
            }

            it("fails if last value is not being emitted in time") {
                let subject = ReplaySubject<Any>.createUnbounded()

                subject.onNext("Hi")
                // Never complete

                expect(subject).last(timeout: 1).to(throwError(RxError.timeout))
            }
        }

        // MARK: Array

        describe("Array") {
            it("checks for timeline") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("Hello")
                subject.onNext("World")
                subject.onCompleted()

                expect(subject).array == ["Hello", "World"]
            }
        }

        describe("Traits") {
            let expectedValue = "some"
            
            it("works with Single") {
                expect(Single.just(expectedValue)).first == expectedValue
            }

            it("works with Maybe") {
                expect(Maybe.just(expectedValue)).first == expectedValue
            }

            it("works with Completable") {
                expect(Observable.just(expectedValue).ignoreElements()).array.to(beEmpty())
            }
        }
    }
}
