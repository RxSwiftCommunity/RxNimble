import Nimble

internal extension Expectation {
    func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U> {
        let exp = expression.cast(closure)
        return Expectation<U>(expression: exp)
    }
}
