//
//  ProgressHUD.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import Foundation
import SVProgressHUD

class ProgressHUD {
    static func show() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    static func dismiss() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    static func configure() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.appAccent)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.white.withAlphaComponent(0.3))        //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)    //Background Color

        SVProgressHUD.setGraceTimeInterval(0.5)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
}
