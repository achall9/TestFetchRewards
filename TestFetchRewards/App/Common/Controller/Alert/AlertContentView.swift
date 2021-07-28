//
//  AlertContentVIew.swift
//  RPS
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class AlertContentView: ModalContentView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var stackButtons: UIStackView!
    var titles: [String] = [] {
        didSet {
            updateButtons()
        }
    }
        
    override func build() {
        super.build()
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateButtons() {
        guard let stackButtons = stackButtons, titles.count > 0 else {
            return
        }
        
        stackButtons.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        for i in 0..<titles.count {
            if i == titles.count - 1 {
                addButton(title: titles[i], index: i, highlight: true)
            }
            else {
                addButton(title: titles[i], index: i, highlight: false)
            }
        }
    }
    
    func addButton(title: String, index: Int, highlight: Bool = false) {
        let button = UIButton(action: #selector(onButtonTapped(_:)), target: self)
        button.tag = index
        button.backgroundColor = .clear
        button.setTitle(title, for: .normal)
        stackButtons.addArrangedSubview(button)
    }
    
    @objc
    func onButtonTapped(_ sender: UIButton) {
        self.completion?(sender.tag, nil)
    }
    
    class func create(with title: String?, message: String?, buttonTitles: [String], completion: ModalCompletion? = nil) -> AlertContentView? {
        let view = AlertContentView.create(xib: "AlertContentView")
        view?.lblTitle?.text = title
        view?.lblTitle?.defaultLineSpacing()
        view?.lblMessage?.text = message
        view?.lblMessage?.defaultLineSpacing()
        view?.titles = buttonTitles
        view?.completion = completion
        return view
    }
}
