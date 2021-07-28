//
//  UIButtonExtension.swift
//  RPS
//
//  Created by Alex on 27/07/2021.
//


import UIKit

extension UIButton {
    open override var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isEnabled {
                    self.alpha = 1.0
                }
                else {
                    self.alpha = 0.4
                }                
            }
        }
    }
}

extension UIButton {
    var font: UIFont? {
        get {
            return self.titleLabel?.font
        }
        set {
            self.titleLabel?.font = newValue
        }
    }
}

extension UIButton {
    @IBInspectable
    var letterSpacing: CGFloat {
        set {
            let attributedString: NSMutableAttributedString
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
            }

            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.string.count))
            setAttributedTitle(attributedString, for: .normal)
        }
        get {
            return self.titleLabel?.attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat ?? 0
        }
    }
}
