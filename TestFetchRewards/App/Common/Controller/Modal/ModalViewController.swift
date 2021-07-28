//
//  ModalViewController.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

enum ModalMode: Int {
    case top
    case middle
    case bottom
    
    func beforeFrame(for contentView: UIView, marginX: CGFloat, superRect: CGRect = UIScreen.main.bounds) -> CGRect {
        switch self {
        case .top:
            return CGRect(x: marginX, y: -contentView.bounds.height, width: (superRect.width - marginX * 2), height: contentView.bounds.height)
        case .middle:
            return CGRect(x: marginX, y: superRect.height, width: (superRect.width - marginX * 2), height: contentView.bounds.height)
        case .bottom:
            return CGRect(x: marginX, y: superRect.height, width: (superRect.width - marginX * 2), height: contentView.bounds.height)
        }
    }
}

class ModalViewController: BaseViewController {
    var contentView: ModalContentView!
    var isAnimated: Bool = false

    var marginX: CGFloat = 20
    var radius: CGFloat = 12
    var mode: ModalMode = .middle
    var tapToDismiss: Bool = true
    
    override func configure() {
        super.configure()
        
        self.view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.5)
        if let container = contentView {
            container.removeFromSuperview()
            container.cornerRadius = radius
            self.view.addSubview(container)
            container.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.left.equalToSuperview().offset(marginX)
                $0.right.equalToSuperview().offset(-marginX)
                $0.height.lessThanOrEqualToSuperview().multipliedBy(0.7)
            }
                        
            if self.mode == .top {
                container.snp.makeConstraints {
                    $0.bottom.equalTo(self.view.snp.top)
                }
            }
            else if self.mode == .middle {
                container.snp.makeConstraints {
                    $0.top.equalTo(self.view.snp.bottom)
                }
            }
            else if self.mode == .bottom {
                container.snp.makeConstraints {
                    $0.top.equalTo(self.view.snp.bottom)
                }
            }
            self.view.layoutIfNeeded()
            
            addGesture()
        }
    }
    
    func addGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        if self.mode == .top {
            gesture.direction = .up
        }
        else if self.mode == .middle {
            gesture.direction = .down
        }
        else if self.mode == .bottom {
            gesture.direction = .down
        }
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(gesture)
    }
    
    @objc
    func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        dismiss()
    }
    
    override func viewWillAppearFirstTime() {
        super.viewWillAppearFirstTime()
        
        if tapToDismiss {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
            gesture.delegate = self
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc
    func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isAnimated == false {
            contentView.frame = self.mode.beforeFrame(for: self.contentView, marginX: self.marginX) //this is for different screen sizes.
            if self.mode == .top {
                contentView.snp.updateConstraints {
                    $0.bottom.equalTo(self.view.snp.top).offset(contentView.bounds.height - radius)
                }
            }
            else if self.mode == .middle {
                contentView.snp.updateConstraints {
                    $0.top.equalTo(self.view.snp.bottom).offset(-contentView.bounds.height/2 - self.view.bounds.height/2)
                }
            }
            else if self.mode == .bottom {
                contentView.snp.updateConstraints {
                    $0.top.equalTo(self.view.snp.bottom).offset(-contentView.bounds.height + radius)
                }
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            isAnimated = true
        }
    }
    
    func dismiss(completion: Block? = nil) {
        if self.mode == .top {
            contentView.snp.updateConstraints {
                $0.bottom.equalTo(self.view.snp.top)
            }
        }
        else if self.mode == .middle {
            contentView.snp.updateConstraints {
                $0.top.equalTo(self.view.snp.bottom)
            }
        }
        else if self.mode == .bottom {
            contentView.snp.updateConstraints {
                $0.top.equalTo(self.view.snp.bottom)
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false)
            completion?()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard gestureRecognizer is UITapGestureRecognizer else {
            return true
        }
        let pos = touch.location(in: self.view)
        if contentView.frame.contains(pos) {
            return false
        }
        return true
    }
}

extension ModalViewController {
    convenience init(contentView: ModalContentView, completion: ModalCompletion? = nil) {
        self.init()
        
        self.contentView = contentView
        contentView.completion = { [weak self] index, data in
            self?.dismiss(completion: {
                completion?(index, data)
            })
        }
    }
    
    convenience init(xib: String, completion: ModalCompletion? = nil) {
        self.init()
        
        self.contentView = ModalContentView.create(xib: xib)
        contentView.completion = { [weak self] index, data in
            self?.dismiss(completion: {
                completion?(index, data)
            })
        }
    }
}
