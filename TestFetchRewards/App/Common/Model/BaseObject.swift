//
//  BaseObject.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit
import ObjectMapper
import RxSwift
import Moya
import Moya_ObjectMapper

typealias SorterFunction = ((BaseObject, BaseObject) -> Bool)

class BaseObject: NSObject, Mappable {
    var id: Int?
    
    static let sorterByAscending: SorterFunction = { obj1, obj2 in
        guard let value1 = obj1.id, let value2 = obj2.id else {
            return false
        }
        return value1 < value2
    }
    
    static let sorterByDescending: SorterFunction = { obj1, obj2 in
        guard let value1 = obj1.id, let value2 = obj2.id else {
            return false
        }
        return value1 < value2
    }


    var stringId: String {
        guard let id = id else {
            return ""
        }
        return "\(id)"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- (map["id"], IntTransform.shared)
    }
    
    static func map<T: Mappable>(json: Any) -> T? {
        let mapper = Mapper<T>()
        return mapper.map(JSONObject: json)
    }
    
    func attach(_ model: BaseObject) {
        id = model.id ?? id
    }
}

//API
extension BaseObject {
    class var provider: APIProvider<APIService> {
        return API.shared.provider
    }
}


extension BaseObject {
    static func == (lhs: BaseObject, rhs: BaseObject) -> Bool {
        guard let lid = lhs.id, let rid = rhs.id else {
            return false
        }
        return lid == rid
    }
}
