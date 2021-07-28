//
//  KeychainManager.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import Foundation
import KeychainSwift
import ObjectMapper
import SwiftyJSON

class KeychainManager {
    static let shared = KeychainManager()
    //KeyChain
    fileprivate let keychain = KeychainSwift(keyPrefix: "stored_data")
    
    subscript(key: String) -> String? {
        get {
            return keychain.get(key)
        }
        set {
            if let value = newValue {
                keychain.set(value, forKey: key)
            }
            else {
                keychain.delete(key)
            }
        }
    }
    
    static func setData(value: Data?, for key: String, isPermanent: Bool = false) {
        guard let data = value else {
            shared.keychain.delete(key)
            return
        }
        shared.keychain.set(data, forKey: key)
    }
    
    static func data(for key: String, isPermanent: Bool = false) -> Data?{
        return shared.keychain.getData(key)
    }
    
    static func clear() {
        shared.keychain.clear()
        UserDefaults.standard.clear()
    }
}

extension KeychainManager {
    func set(key: String, value: String?, isPermanent: Bool) {
        if isPermanent {
            setPermanent(key: key, value: value)
        }
        else {
            set(key: key, value: value)
        }
    }
    
    func get(key: String, isPermanent: Bool) -> String? {
        if isPermanent {
            return getPermanent(key: key)
        }
        else {
            return get(key: key)
        }
    }
        
    func set(key: String, value: String?) {
        if let value = value {
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
        }
        else {
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    func get(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func setPermanent(key: String, value: String?) {
        self[key] = value
    }
    
    func getPermanent(key: String) -> String? {
        return self[key]
    }
}

extension KeychainManager {
    static func setBool(value: Bool, for key: String, isPermanent: Bool = false) {
        shared.set(key: key, value: "\(value)", isPermanent: isPermanent)
    }
    
    static func bool(for key: String, isPermanent: Bool = false) -> Bool {
        return shared.get(key: key, isPermanent: isPermanent)?.toBool() ?? false
    }
    
    static func setString(value: String?, for key: String, isPermanent: Bool = false) {
        shared.set(key: key, value: value, isPermanent: isPermanent)
    }
    
    static func string(for key: String, isPermanent: Bool = false) -> String?{
        return shared.get(key: key, isPermanent: isPermanent)
    }
    
    static func setInt(value: Int?, for key: String, isPermanent: Bool = false) {
        if let value = value {
            shared.set(key: key, value: "\(value)", isPermanent: isPermanent)
        }
        else {
            shared.set(key: key, value: nil, isPermanent: isPermanent)
        }
    }
    
    static func integer(for key: String, isPermanent: Bool = false) -> Int? {
        if let value = shared.get(key: key, isPermanent: isPermanent) {
            return Int(value)
        }
        return nil
    }
    
    static func setDict(value: [String: Any], for key: String, isPermanent: Bool = false) {
        shared.set(key: key, value: JSON(value).rawString(), isPermanent: isPermanent)
    }
    
    static func dict(for key: String, isPermanent: Bool = false) -> [String: Any]? {
        guard let jsonString = shared.get(key: key, isPermanent: isPermanent) else {
            return nil
        }
        return JSON.init(parseJSON: jsonString).dictionaryObject
    }
    
    static func setArray(value: [Any]?, for key: String, isPermanent: Bool = false) {
        if let value = value {
            shared.set(key: key, value: JSON(value).rawString(), isPermanent: isPermanent)
        }
        else {
            shared.set(key: key, value: nil, isPermanent: isPermanent)
        }
    }
    
    static func array(for key: String, isPermanent: Bool = false) -> [Any]? {
        guard let jsonString = shared.get(key: key, isPermanent: isPermanent) else {
            return nil
        }
        return JSON.init(parseJSON: jsonString).arrayObject
    }
}

extension UserDefaults {
    func clear() {
        let dictionary = self.dictionaryRepresentation()
        dictionary.keys.forEach { [weak self] key in
            if key.contains("fetchRewards") {
                self?.removeObject(forKey: key)
            }
        }
    }
}
