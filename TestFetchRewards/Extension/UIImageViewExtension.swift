//
//  UIImageViewExtension.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//



import UIKit
import Kingfisher

extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
 
extension UIImageView {
    func loadImage(url: URL?, placeholder imageName: String? = "img_placeholder", completion: Completion? = nil) {
        let placeholder = imageName != nil ? UIImage(named: imageName!) : nil
        self.kf.setImage(with: url, placeholder: placeholder) { result in
            switch result {
            case .success(let value):
                completion?(value.image)
            default:
                completion?(nil)
            }
        }
    }
    
    func loadImage(string: String?, placeholder imageName: String? = "img_placeholder", completion: Completion? = nil) {
        guard let urlString = string?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {
            loadImage(url: nil, placeholder: imageName, completion: completion)
            return
        }
        loadImage(url: url, placeholder: imageName, completion: completion)
    }
}

