import Quick
import Nimble
import RxSwift
import RxNimble

class RxNimbleTest: QuickSpec {
    override func spec() {

        it("works with plain observables") {
            let subject = ReplaySubject<String>.createUnbounded()
            subject.onNext("Hi")

            expect(subject.asObservable()) == "Hi"
        }

        it("only checks the first value") {
            let subject = ReplaySubject<String>.createUnbounded()
            subject.onNext("Hi")
            subject.onNext("Hello")

            expect(subject.asObservable()) == "Hi"
        }

        it("works with variables") {
            let subject = Variable("Hi")
            
            expect(subject) == "Hi"
        }

        it("can use different matchers") {
            let subject = ReplaySubject<String>.createUnbounded()
            subject.onNext("")

            expect(subject).first.to(beEmpty())
        }
    }
}
