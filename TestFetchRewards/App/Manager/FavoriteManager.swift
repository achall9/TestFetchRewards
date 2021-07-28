//
//  FavoriteManager.swift
//  TestFetchRewards
//
//  Created by Alex on 28/07/2021.
//

import UIKit

class FavoriteManager: NSObject {
    static let shared = FavoriteManager()
    
    var favoriteShow: [String: Bool]{
        get {
            return (KeychainManager.dict(for: "fetchRewards_favorite_show") as? [String: Bool]) ?? [:]
        }
        set {
            KeychainManager.setDict(value: newValue, for: "fetchRewards_favorite_show")
        }
    }
}
