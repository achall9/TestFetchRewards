//
//  BaseHeaderFooterView.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class BaseHeaderFooterView: UITableViewHeaderFooterView {
    class var identifier: String {
        return "base_header_footer"
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    var section: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func configure() {
        self.backgroundView = UIView()
        backgroundView?.backgroundColor = .clear
    }
}

extension BaseHeaderFooterView {    
    class func registerWithNib(to tableView: UITableView, nibName: String? = nil) {
        let nibName = nibName ?? self.className
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: self.identifier)
    }
    
    class func register(to tableView: UITableView) {
        tableView.register(self, forHeaderFooterViewReuseIdentifier: self.identifier)
    }
}
