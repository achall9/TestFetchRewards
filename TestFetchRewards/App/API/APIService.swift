//
//  APIConstant.swift
//  ActionIWS
//
//  Created by Alex on 26/07/2021.
//

import Foundation
import ObjectMapper
import Moya

enum APIService {
    
    ///Chapters
    case events(filter: String?)
    case getEvent(id: Int)
    
    case performers
    case getPerformer(id: Int)
    
    case venues
    case getVenue(id: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.seatgeek.com/2")!
    }
    var clientID: String {
        return "MjE3NTIxMDZ8MTYyNzMxMTUwMS40MTQzNTE"
    }
    
    var path: String {
        switch self {
        case .events:
            return "/events"
        case .getEvent(let id):
            return "/events/\(id)"
        case .performers:
            return "/performers"
        case .getPerformer(let id):
            return "/performers/\(id)"
        case .venues:
            return "/venues"
        case .getVenue(let id):
            return "/venues/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var params: [String: Any]? {
        return ["client_id" : clientID]
    }
    
    var task: Task {
        if let params = self.params {
            if self.method == .get {
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
            else {
                return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            }
        }
        else {
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var showHud: Bool {
        return true
    }
}

extension APIService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .none
    }
}

struct ServerResponse: Mappable {
    var success: Bool!
    var message: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
