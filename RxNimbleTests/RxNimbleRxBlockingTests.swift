import Quick
import Nimble
import RxSwift
import RxNimbleRxBlocking

class RxNimbleRxBlockingTests: QuickSpec {
    override func spec() {
        //MARK: First
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
        }

        //MARK: Last
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
        }

        //MARK: Array
        describe("Array") {
            it("checks for timeline") {
                let subject = ReplaySubject<String>.createUnbounded()
                subject.onNext("Hello")
                subject.onNext("World")
                subject.onCompleted()

                expect(subject).array == ["Hello", "World"]
            }
        }
    }
}
