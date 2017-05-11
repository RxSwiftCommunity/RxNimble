import Nimble

extension Expectation {
    init(_ expression: Expression<T>) {
        self.expression = expression
    }

    internal func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U>{
        let exp = expression.cast(closure)
        return Expectation<U>(exp)
    }
}
