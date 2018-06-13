import Nimble

extension Expectation {
    #if swift(>=4.1)
    #else
    init(_ expression: Expression<T>) {
        self.expression = expression
    }
    #endif

    internal func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U>{
        let exp = expression.cast(closure)
        #if swift(>=4.1)
        return Expectation<U>(expression: exp)
        #else
        return Expectation<U>(exp)
        #endif
    }
}
