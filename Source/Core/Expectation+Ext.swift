import Nimble

extension SyncExpectation {
    #if swift(>=4.1)
    #else
    init(_ expression: SyncExpectation<Value>) {
        self.expression = expression
    }
    #endif

    internal func transform<U>(_ closure: @escaping (Value?) throws -> U?) -> SyncExpectation<U>{
        let exp = expression.cast(closure)
        #if swift(>=4.1)
        return SyncExpectation<U>(expression: exp)
        #else
        return SyncExpectation<U>(exp)
        #endif
    }
}
