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
    }
}
