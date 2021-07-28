//
//  UIViewControllerExtension.swift
//
//  Created by Alex on 27/07/2021.
//


import UIKit
import SafariServices

extension UIViewController {
    func isRootController() -> Bool {
        let vc = self.navigationController?.viewControllers.first
        if self == vc {
            return true
        }
        return false
    }
    
    func showAlert(_ title: String = "Sorry", message: String? = nil, actionTitle: String = "OK", completionHandler: (() -> Void)? = nil) {
        UIManager.showAlert(title: title, message: message, buttons: [actionTitle], completion: { (index, _) in
            completionHandler?()
        }, parentController: self)
    }

    func presentMailViewController(_ email: String) {
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
            return
        }
    }
}

extension UIViewController: SFSafariViewControllerDelegate {
    func presentWebViewController(_ url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        if #available(iOS 13.0, *) {
//            safariVC.overrideUserInterfaceStyle = .light
        }
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }
}

extension UIPageViewController {
    func moveToNext() {
        guard let currentViewController = self.viewControllers?.first else { return debugPrint("Failed to get current view controller") }
        guard let nextViewController = self.dataSource?.pageViewController( self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
}
