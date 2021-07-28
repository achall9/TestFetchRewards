//
//  StringExtensions.swift
//
//  Created by Alex on 27/07/2021.
//


import Foundation
import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func stripHtml() -> String {
        
        return  self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "\n\n", with: " ")
        
    }
    
    func getURL() -> URL {
        
        return URL(string:self)!
        
    }
    
    func getURLOpt() -> URL! {
        return URL(string:self)
    }
    
    func getURLWithEscapeChar() -> URL {
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        return URL(string:escapedString!)!
    }
    
    func substringToIndex(index:Int) -> String {
        
        let index: String.Index = self.index(self.startIndex, offsetBy: index)
        
        let substring: String = String(self[...index])
        
        return substring
        
    }
    
    
    func substringFromIndex(index:Int) -> String {
        
        let index: String.Index = self.index(self.startIndex, offsetBy: index)
        
        let substring: String = String(self[index...])
        
        return substring
        
    }
    
    func substringWithRange(sIndex:Int,eIndex:Int) -> String
    {
        
        let startIndex: String.Index = self.index(self.startIndex, offsetBy: sIndex)
        let endIndex: String.Index = self.index(self.startIndex, offsetBy: eIndex)
        
        let newStr: String = String(self[startIndex..<endIndex])
        
        return newStr
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    static func booleanToString(_ boolean: Bool) -> String {
        
        if boolean {
            
            return "true"
            
        }
        else {
            
            return "false"
            
        }
        
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func getBase64Value()->String{
        return self.data(using: String.Encoding.utf8)!.base64EncodedString(options: [])
    }
    func trim()->String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func replacingCharacters(in range: NSRange, with replacement: String) -> String {
        
        let newText: String = (self as NSString).replacingCharacters(in: range, with: replacement)
        
        return newText
        
    }
    
    func cleanUpJSON() -> String {
        return self.replacingOccurrences(of: "\n", with: "\\n")
    }
}

// Validation
extension String {
    func numbersOnly() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func charactersOnly() -> String {
        return self.components(separatedBy: CharacterSet.letters.inverted).joined()
    }
    
    func formattedNumber() -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        // let mask = "+X (XXX) XXX-XXXX"
        // let mask = "(XXX) XXX-XXXX"
        var mask: String
        if cleanPhoneNumber.starts(with: "1") {
            mask = "X (XXX) XXX-XXXX"
        } else {
            mask = "(XXX) XXX-XXXX"
        }
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }

    func isValidThumbnail() -> Bool {
        let thumbnailRegex = "[A-Z0-9a-z_-]+\\.(jpg|png|jpeg)"
        let thumbnailTest = NSPredicate(format: "SELF MATCHES %@", thumbnailRegex)
        return thumbnailTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self.trim())
        return result
    }
        
    func isValidPassword() -> Bool {
        /*
        let regularExpression = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
        */
        return self.count >= 8
    }
    
    // at least one uppercase
    func isValidName() -> Bool {
        let name = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regEx = ".*[a-z]+.*"
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        return test.evaluate(with: name)
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func isValidZipCode() -> Bool {
        return self.isNumeric && self.count == 5
    }
    
    func nextLetter(_ letter: String) -> String? {
        // Check if string is build from exactly one Unicode scalar:
        guard let uniCode = UnicodeScalar(letter) else {
            return nil
        }
        switch uniCode {
        case "A" ..< "Z":
            return String(UnicodeScalar(uniCode.value + 1)!)
        default:
            return nil
        }
    }

    func getInitial() -> String {
        guard count > 0 else { return "" }
        return String(self.capitalized[self.capitalized.startIndex])
    }
}

extension String {
    func underlinedText(font: UIFont, color: UIColor) -> NSMutableAttributedString{
        let attrs: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.underlineStyle : 1
        ]
        
        return NSMutableAttributedString(string: self, attributes: attrs)
    }
}

extension String {
    var doubleValue: Double? {
        return Double(self)
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

extension String {
    var httpize: String {
        return self.hasPrefix("http") ? self : "http://\(self)"
    }
    
    var httpsize: String {
        return self.hasPrefix("http") ? self : "https://\(self)"
    }
}

