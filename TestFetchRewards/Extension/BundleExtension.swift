//
//  BundleExtension.swift
//
//  Created by Alex on 27/07/2021.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    static var versionInfo: String? {
        guard let version = Bundle.main.releaseVersionNumber,
            let build = Bundle.main.buildVersionNumber else {
                return nil
        }
        return "Current Version \(version)-(\(build))"
    }
}
