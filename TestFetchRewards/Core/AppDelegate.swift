//
//  AppDelegate.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadFramework(launchOptions)
        AppManager.shared.showNext()
        return true
    }

    func loadFramework(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //Siren
        
        UIManager.shared.initTheme()
        ProgressHUD.configure()
    }
}

