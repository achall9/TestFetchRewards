//
//  BaseViewController.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var isViewAppeared: Bool = false
    var isLoading: Bool = false
    
    // Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // RxCocoa
    let disposeBag = DisposeBag()
    
    // Navigation Bar
    @IBInspectable var showTopBar: Bool = false
    @IBInspectable var showBackButton: Bool = true
    
    var background: String? //background image name
    {
        return nil
    }
    
    // UnWind Segue
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    var favoriteShow: [String: Bool] = [:] {
        didSet {
            KeychainManager.setDict(value: favoriteShow, for: "fetchRewards_favorite_show")
        }
    }
    
    // Controller Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = []
        
        navigationController?.delegate = self
        configure()
    }
    
    func configure() {
        configureUI()
        setupRx()
    }
    
    //must be overrided
    func configureUI() {
        
    }
    
    //must be overrided
    func setupRx() {
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
        
        if (isViewAppeared == false) {
            isViewAppeared = true
            self.viewWillAppearFirstTime()
        }
    }
    
    func viewWillAppearFirstTime() {
        //must be overrided
    }
    
    @objc
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateNavigationBar() {
        if let navController = self.navigationController {
            navController.interactivePopGestureRecognizer?.delegate = self
            navController.setNavigationBarHidden(!showTopBar, animated: true)
            navController.navigationBar.isTranslucent = false
          
            if navController.navigationBar.topItem?.title == nil || navController.navigationBar.topItem?.title == self.title {
                navController.navigationBar.topItem?.title = self.title
            }
        }
    }
    
    deinit {
    }
    
    /**
        Gesture Recognizer for //Navigation Swiping
     */
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//present or dismiss
extension BaseViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let parent = self.parent {
            parent.dismiss(animated: flag, completion: nil)
        }
        else {
            super.dismiss(animated: flag, completion: nil)
        }
    }
}

extension BaseViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count > 1 {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem()
    }
}

