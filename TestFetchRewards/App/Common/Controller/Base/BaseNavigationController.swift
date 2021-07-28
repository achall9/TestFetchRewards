//
//  BaseNavigationController.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class BaseNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    func find(of type: UIViewController.Type) -> UIViewController? {
        for controller in self.viewControllers {
            if controller.isKind(of: type) {
                return controller
            }
        }
        return nil
    }
    
    func go(to controller: UIViewController, animated: Bool = true) {
        if let old = self.find(of: type(of: controller)) {
            self.popToViewController(old, animated: animated)
        }
        else {
            self.pushViewController(controller, animated: animated)
        }
    }
    
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    fileprivate func prepareFade() {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
    }
    
    func replace(to controller: UIViewController, animated: Bool = true, fade: Bool = true) {
        guard let current = self.topViewController else {
            return
        }
        
        var controllers = self.viewControllers
        controllers.remove(current)
        controllers.append(controller)
        
        if fade {
            prepareFade()
            self.setViewControllers(controllers, animated: false)
        }
        else {
            self.setViewControllers(controllers, animated: animated)
        }
    }
}
