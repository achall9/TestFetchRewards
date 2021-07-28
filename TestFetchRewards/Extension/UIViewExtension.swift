//
//  UIViewExtension.swift
//
//  Created by Alex on 27/07/2021.
//


import UIKit
import QuartzCore

extension UIView {
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
    }
}

@IBDesignable extension UIView{
    @IBInspectable
    public var cornerRadius: CGFloat{
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }get{
            return self.layer.cornerRadius
        }
    }
}

//Flip, Rotate
extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        self.layer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        self.layer.transform = CATransform3DMakeRotation(radians, 0, 0, 1);
    }
    
    func flip(flipped: Bool = true) {
        self.layer.transform = CATransform3DMakeRotation(flipped ? .pi : 0, 0, 0, 1);
    }
}

//Tap Action
extension UIView {
    func addTapAction(target: Any?, action: Selector?) {
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)
    }
    
    func addSwipeAction(direction: UISwipeGestureRecognizer.Direction, target: Any?, action: Selector?) {
        let gesture = UISwipeGestureRecognizer(target: target, action: action)
        gesture.direction = direction
        self.addGestureRecognizer(gesture)
    }
}

extension UIStackView {
    func safelyRemoveArrangedSubviews() {
        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UIView {
    func roundTop(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    func roundBottom(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}


extension UIView {
    func setVisible(_ show: Bool, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        let alpha: CGFloat = show ? 1.0 : 0.0
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = alpha
        }
    }
}

extension CATransaction {
    /**
            Disable implicit animation.
            you can use this function to change layer properties that you don't want to animate
            Example: disableAnimations {  view.layer.frame = rect  } //Default animation is now disabled.
     */
    static func disableAnimations(_ completion: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        completion()
        CATransaction.commit()
    }
}

private var GlowLayerAssociatedObjectKey = "GlowLayerAssociatedObjectKey"

public extension UIView {
    
    private var glowLayer: CALayer? {
        get {
            return objc_getAssociatedObject(self, &GlowLayerAssociatedObjectKey) as? CALayer
        } set {
            objc_setAssociatedObject(self, &GlowLayerAssociatedObjectKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Starts glowing view with options.
    ///
    /// - parameter color:         Glow color.
    /// - parameter fromIntensity: Glow start intensity.
    /// - parameter toIntensity:   Glow end intensity.
    /// - parameter fill:          If true, glows inside the view as well. If not, only glows outer border.
    /// - parameter position:      Sets position of glow over view. Defaults center.
    /// - parameter duration:      Duration of one pulse of glow.
    /// - parameter shouldRepeat:  If true, repeats until stop. If not, pulses just once.
    /// - parameter glowOnce:      Should it glow once and stop glowing or glows until `stopGlowing` called. It's not effective if repeat is on. Defauts true.
    func startGlowing(
        color: UIColor = .white,
        fromIntensity: CGFloat = 0,
        toIntensity: CGFloat = 1,
        fill: Bool = false,
        position: CGPoint? = nil,
        duration: TimeInterval = 1,
        repeat shouldRepeat: Bool = true,
        glowOnce: Bool = true) {
        
        // If we're already glowing, don't bother
        guard glowLayer == nil
        else { return }
        
        glowLayer = CALayer()
        guard let glowLayer = glowLayer
        else { return }
        
        // The glow image is taken from the current view's appearance.
        // As a side effect, if the view's content, size or shape changes,
        // the glow won't update.
        var image: UIImage?
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            if fill {
                let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
                color.setFill()
                path.fill(with: .sourceAtop, alpha: 1.0)
            }
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        // Setup glowLayer
        glowLayer.frame = CGRect(origin: position ?? bounds.origin, size: frame.size)
        glowLayer.contents = image?.cgImage
        glowLayer.opacity = 0
        glowLayer.shadowColor = color.cgColor
        glowLayer.shadowOffset = CGSize.zero
        glowLayer.shadowRadius = 10
        glowLayer.shadowOpacity = 1
        glowLayer.rasterizationScale = UIScreen.main.scale
        glowLayer.shouldRasterize = true
        layer.addSublayer(glowLayer)
        
        // Create an animation that slowly fades the glow view in and out forever.
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromIntensity
        animation.toValue = toIntensity
        animation.repeatCount = shouldRepeat ? .infinity : 0
        animation.duration = duration
        animation.autoreverses = shouldRepeat || glowOnce
        animation.isRemovedOnCompletion = shouldRepeat || glowOnce
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        glowLayer.add(animation, forKey: "glowViewPulseAnimation")
        
        // Stop glowing after duration if not repeats
        if !shouldRepeat && glowOnce {
            let delay = duration * Double(Int64(NSEC_PER_SEC))
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + delay,
                execute: { [weak self] in
                    self?.stopGlowing()
                })
        }
    }
    
    /// Stop glowing by removing the glowing view from the superview
    /// and removing the association between it and this object.
    func stopGlowing() {
        glowLayer?.removeFromSuperlayer()
        glowLayer = nil
    }
}
