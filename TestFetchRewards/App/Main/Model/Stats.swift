//
//  Stats.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper

class Stats: BaseObject {
    var listing_count:Int?
    var average_price : Int?
    var lowest_price : Int?
    var highest_price : Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        listing_count           <- (map["listing_count"], IntTransform.shared)
        average_price           <- (map["average_price"], IntTransform.shared)
        lowest_price            <- (map["lowest_price"], IntTransform.shared)
        highest_price           <- (map["highest_price"], IntTransform.shared)
    }
}
