//
//  UIHelper.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

class UIHelper {
    
}

extension UIView {
    func addChild(view: UIView) {
        if self is UIStackView {
            (self as! UIStackView).addArrangedSubview(view)
        }
        else {
            self.addSubview(view)
        }
    }
}

extension UILabel {
    convenience init(font: UIFont, color: UIColor, backgroundColor: UIColor = .clear, superView: UIView? = nil) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = color
        self.backgroundColor = backgroundColor
        superView?.addChild(view: self)
    }
    
    func defaultLineSpacing() {
        self.setLineSpacing(lineHeightMultiple: 1.5, alignment: self.textAlignment)
    }
}

extension UIButton {
    convenience init(image: UIImage? = nil, selectedImage: UIImage? = nil, action: Selector, target: Any, superView: UIView? = nil) {
        self.init(type: .custom)
        self.frame = .zero
        self.backgroundColor = .clear
        
        self.setImage(image, for: .normal)
        self.setImage(selectedImage, for: .selected)
        
        self.addTarget(target, action: action, for: .touchUpInside)
        
        superView?.addChild(view: self)
    }
}


extension UIImageView {
    convenience init(backgroundColor: UIColor = .clear, contentMode: UIView.ContentMode = UIView.ContentMode.scaleAspectFit, superView: UIView? = nil) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.contentMode = contentMode
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        superView?.addChild(view: self)
    }
    
}
