//
//  Constants.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit

struct Constants {
    
    struct Keys {
        static let welcome_shown = "welcome_shown"
    }
}

typealias AsyncCompletion = ((Bool, Any?)->Void)
typealias Completion = ((Any?)->Void)
typealias Block = (()->Void)
