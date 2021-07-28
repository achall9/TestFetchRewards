//
//  Performer.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper

class Performer: BaseObject {
    
    var name: String?
    var short_name: String?
    var url: URL?
    var image: URL?
    var images: [ImageItem]?
    var primary: Bool?
    var score: Int?
    var type: String?
    var slug: String?

    override func mapping(map: Map) {
        super.mapping(map: map)
        name                <- map["name"]
        short_name          <- map["short_name"]
        url                 <- (map["url"], URLTransform.shared)
        image               <- (map["image"], URLTransform.shared)
        images              <- map["images"]
        primary             <- (map["primary"], BoolTransform.shared)
        score               <- (map["score"], IntTransform.shared)
        type                <- map["type"]
        slug                <- map["slug"]
    }
}

