//
//  BaseCustomView.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class BaseCustomView: UIControl {
    @IBInspectable public var autostart: Bool = false
    @IBInspectable public var autohide: Bool = false
    @IBInspectable public var animation: String = ""
    @IBInspectable public var force: CGFloat = 1
    @IBInspectable public var delay: CGFloat = 0
    @IBInspectable public var duration: CGFloat = 0.7
    @IBInspectable public var damping: CGFloat = 0.7
    @IBInspectable public var velocity: CGFloat = 0.7
    @IBInspectable public var repeatCount: Float = 1
    @IBInspectable public var x: CGFloat = 0
    @IBInspectable public var y: CGFloat = 0
    @IBInspectable public var scaleX: CGFloat = 1
    @IBInspectable public var scaleY: CGFloat = 1
    @IBInspectable public var rotate: CGFloat = 0
    @IBInspectable public var curve: String = ""
    public var opacity: CGFloat = 1
    public var animateFrom: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        build()
    }
    
    func build() {
        self.backgroundColor = .clear
        //add sub views here
    }
}

extension BaseCustomView {
    class func create(xib name: String? = nil) -> Self? {
        let xibName = name ?? Self.className
        let view = Bundle.main.loadNibNamed(xibName, owner: nil, options: nil)?.first as? Self
        return view
    }
}
