//
//  NSStringExtensions.swift
//
//  Created by Alex on 27/07/2021.
//


import Foundation

extension NSString{
    func decodeBase64()->String?{
        let data = Data(base64Encoded: self as String, options: NSData.Base64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: String.Encoding.utf8)!
    }
    
    func encodeBase64()->String?{
        let data = self.data(using: String.Encoding.utf8.rawValue)
        return (data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
    }
}
