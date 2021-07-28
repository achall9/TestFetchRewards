//
//  Taxonomie.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper

class Taxonomie: BaseObject {
    var parent_id:Int?
    var name : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        parent_id       <- (map["parent_id"], IntTransform.shared)
        name            <- map["name"]
    }
}
