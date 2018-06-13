import Nimble

internal extension Expectation {
    #if swift(<=4.1)
    init(_ expression: Expression<T>) {
        self.expression = expression
    }
    #endif

    func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U> {
        let exp = expression.cast(closure)
        #if swift(<=4.1)
        return Expectation<U>(exp)
        #else
        return Expectation<U>(expression: exp)
        #endif
    }
}
