//
//  UITextFieldExtension.swift
//  TestFetchRewards
//
//  Created by OSX on 10/2/20.
//

import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            if let color = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "" , attributes: [NSAttributedString.Key.foregroundColor: color])
            }
        }
    }
}
