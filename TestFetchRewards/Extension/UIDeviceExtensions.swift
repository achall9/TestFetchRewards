//
//  UIDeviceExtensions.swift
//
//  Created by Alex on 27/07/2021.
//

import Foundation
import UIKit

extension UIDevice {
    var isIphoneX: Bool {
        if #available(iOS 11.0, *), isIphone {
            if isLandscape {
                if let leftPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left, leftPadding > 0 {
                    return true
                }
                if let rightPadding = UIApplication.shared.keyWindow?.safeAreaInsets.right, rightPadding > 0 {
                    return true
                }
            } else {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 0 {
                    return true
                }
                if let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomPadding > 0 {
                    return true
                }
            }
        }
        return false
    }

    var isLandscape: Bool {
        return orientation.isLandscape || UIApplication.shared.statusBarOrientation.isLandscape
    }

    var isPortrait: Bool {
        return orientation.isPortrait || UIApplication.shared.statusBarOrientation.isPortrait
    }

    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }

    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
}
