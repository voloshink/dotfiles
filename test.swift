import Foundation

public func fib(_ x: Int) async -> Int {
    if (x < 0) {
        return 0
    } else if x <= 1 {
        return x
    } 

    async let x1 = fib(x - 1)
    async let x2 = fib(x - 2)
    return await x1 + x2
    }

undefinedSymbol = 32
