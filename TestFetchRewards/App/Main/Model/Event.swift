//
//  Event.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper
import RxSwift
import SwiftyJSON

class Event: BaseObject {
    var stats:Stats?
    var title : String?
    var url : URL?
    var datetime_local : Date?
    var performers: [Performer]?
    var venue : Venue?
    var short_title : String?
    var datetime_utc : Date?
    var score : Float?
    var taxonomies : [Taxonomie]?
    var type:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        stats               <- map["stats"]
        title               <- map["title"]
        url                 <- (map["url"], URLTransform.shared)
        datetime_local      <- (map["datetime_local"], DateFormatTransform.shared)
        performers          <- map["performers"]
        venue               <- map["venue"]
        short_title         <- map["short_title"]
        datetime_utc        <- (map["datetime_utc"], DateFormatTransform.shared)
        score               <- map["score"]
        taxonomies          <- map["taxonomies"]
        type                <- map["type"]
    }
    
    lazy var imageUrl: URL? = {
        if let performer = performers?.first {
            return performer.image
        }
        return nil
    }()
    
    lazy var allText: String = {
        return Mirror(reflecting: self).children.compactMap({ property in
            if let value = property.value as? String {
                return value
            } else { return nil }
        }).joined(separator: " ")
    }()
}

extension Event {
    static func get(_ filter:String?) -> Single<[Event]> {
       return Self.provider.request(.events(filter:filter)).filterResponse().mapArray(Event.self)
    }
}
