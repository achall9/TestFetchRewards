//
//  AppManager.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit
import ObjectMapper
import CoreLocation

class AppManager: NSObject {
    static let shared = AppManager()
    
    var allowAccessShowen: Bool = false
    var splashScreenShown: Bool = false
}

///App Flow
extension AppManager {
    func showNext() {
        UIManager.showMain(animated: true)
    }
}
