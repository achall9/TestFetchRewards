//
//  PrimitiveExtension.swift
//
//  Created by Alex on 27/07/2021.
//


import Foundation

extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
    
    func randomElements() -> [Element] {
        if self.count == 0 {
            return []
        }
        
        let count = Int.random(in: 0..<self.count)
        return self[randomPick: count]
    }
}

extension Array where Element: Sequence {
    func join() -> Array<Element.Element> {
        return self.reduce([], +)
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
        }
    }
}

extension NSObject {
    class var classFullName: String { return NSStringFromClass(self)   }
    
    class var className: String {
        return (classFullName as NSString).pathExtension
    }
}

extension DispatchQueue {
    func execute(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}

extension String {
    
}

extension Double {
    func truncate(by digits: Int) -> Double? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = digits
        formatter.numberStyle = .decimal

        return formatter.string(from: self as NSNumber)?.doubleValue
    }
    
    var stringValue: String {
        return "\(self)"
    }
    
    func toString(decimal digit: Int = 0) -> String {
        return String(format: "%.\(digit)f", self)
    }
    
    func toCurrency(fraction digits: Int = 2, currency symbol: String = "$", code: String = "USD") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.currencyCode = code
        formatter.maximumFractionDigits = digits
        return formatter.string(for: self)
    }
}

extension Int {
    var stringValue: String {
        return "\(self)"
    }
    
    var stringInThousands: String {
        guard self >= 1000 else {
            return "\(self)"
        }
        
        let doubleValue = Double(self)/1000.0
        return doubleValue.toString(decimal: 1) + "k"
    }
}

extension RangeReplaceableCollection where Element: Equatable {
    @discardableResult
    mutating func appendIfNotContains(_ element: Element) -> (appended: Bool, memberAfterAppend: Element) {
        if let index = firstIndex(of: element) {
            return (false, self[index])
        } else {
            append(element)
            return (true, element)
        }
    }
}
