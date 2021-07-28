//
//  Venue.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper
import MapKit

class Venue: BaseObject {
    var city : String?
    var name : String?
    var extened_address : String?
    var url : URL?
    var country : String?
    var state : String?
    var score : Float?
    var postal_code : String?
    var location : CLLocationCoordinate2D?
    var address : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
                
        city                    <- map["city"]
        name                    <- map["name"]
        extened_address         <- map["extened_address"]
        url                     <- (map["url"], URLTransform.shared)
        country                 <- map["country"]
        state                   <- map["state"]
        score                   <- map["score"]
        postal_code             <- map["postal_code"]
        location                <- (map["location"], CoordinateTransform.shared)
        address                 <- map["address"]
    }
}
