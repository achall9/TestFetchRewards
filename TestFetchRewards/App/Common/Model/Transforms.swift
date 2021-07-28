//
//  Transforms.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import Foundation
import ObjectMapper
import MapKit

extension DateTransform {
    static let shared = DateTransform()
}

extension URLTransform {
    static let shared = URLTransform()
}

open class DateFormatTransform: TransformType {
    static let shared = DateFormatTransform()
    public typealias Object = Date
    public typealias JSON = String
    var format: String = "yyyy-MM-dd'T'HH:mm:ss"
        
    init(_ format: String = "yyyy-MM-dd'T'HH:mm:ss") {
       self.format = format
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateStr = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: dateStr) {
                return date
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.string(withFormat: self.format)
        }
        return nil
    }
}

open class StringArrayTransform: TransformType {
    static let shared = StringArrayTransform()
    public typealias Object = [String]
    public typealias JSON = String

    open func transformFromJSON(_ value: Any?) -> [String]? {
        if let value = value as? String {
            let data = value.data(using: .utf8)!
            guard let array = try? JSONDecoder().decode([String].self, from: data) else {
                return nil
            }
            return array
        }
        return nil
    }
    
    open func transformToJSON(_ value: [String]?) -> String? {
        if let value = value {
            guard let data = try? JSONEncoder().encode(value) else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

open class IntTransform: TransformType {
    static let shared = IntTransform()
    public typealias Object = Int
    public typealias JSON = Any
    
    open func transformFromJSON(_ value: Any?) -> Object? {
        guard let value = value else {
            return nil
        }
        
        if value is String {
            return Int(value as! String)
        }
        else if value is Int {
            return (value as! Int)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return "\(value)"
        }
        return nil
    }
}

open class DoubleTransform: TransformType {
    static let shared = DoubleTransform()
    public typealias Object = Double
    public typealias JSON = Any
    
    open func transformFromJSON(_ value: Any?) -> Object? {
        guard let value = value else {
            return nil
        }
        
        if value is String {
            return Double(value as! String)
        }
        else if value is Double {
            return (value as! Double)
        }
        else if value is Int {
            return Double(value as! Int)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return "\(value)"
        }
        return nil
    }
}

open class BoolTransform: TransformType {
    static let shared = BoolTransform()
    public typealias Object = Bool
    public typealias JSON = Any
    
    open func transformFromJSON(_ value: Any?) -> Object? {
        guard let value = value else {
            return nil
        }
        
        if value is String {
            let boolStr = (value as! String).lowercased()
            return boolStr == "true" || boolStr == "1"
        }
        else if value is Bool {
            return (value as! Bool)
        }
        else if value is Int {
            return (value as! Int) != 0
        }
        return nil
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value ? "true" : "false"
        }
        return nil
    }
}

open class CoordinateTransform: TransformType {
    static let shared = CoordinateTransform()
    public typealias Object = CLLocationCoordinate2D
    public typealias JSON = Any
    
    open func transformFromJSON(_ value: Any?) -> Object? {
        guard let value = value else {
            return nil
        }
        
        if value is [String:Double] {
            guard let lat = (value as! [String:Double])["lat"] else { return nil }
            guard let lon =  (value as! [String:Double])["lon"] else { return nil }
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        else if value is [String:Float] {
            guard let lat = (value as! [String:Double])["lat"] else { return nil }
            guard let lon =  (value as! [String:Double])["lon"] else { return nil }
            return CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lon))
        }
        return nil
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return ["lat":value.latitude, "lon":value.longitude]
        }
        return nil
    }
}
