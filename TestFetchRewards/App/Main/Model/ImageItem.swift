//
//  ImageItem.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit
import ObjectMapper

class ImageItem: BaseObject {
    var large : URL?
    var huge : URL?
    var small : URL?
    var medium : URL?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        large       <- (map["large"], URLTransform.shared)
        huge        <- (map["huge"], URLTransform.shared)
        small       <- (map["small"], URLTransform.shared)
        medium      <- (map["medium"], URLTransform.shared)
    }
}
