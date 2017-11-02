import Quick
import Nimble
import RxSwift
import RxNimble

class RxNimbleTest: QuickSpec {
    override func spec() {
        /// A type-erased `Swift.Error` for testing purposes
        struct AnyError: Swift.Error {
            let message: String
            init(_ message: String = "") {
                self.message = message
            }
        }

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
                subject.onError(AnyError())

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
                subject.onError(AnyError())

                expect(subject).last.to(throwError())
            }
        }
    }
}
