//
//  BaseCollectionViewCell.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath!
    weak var controller: UIViewController?
    var collectionView: UICollectionView!
    
    class var identifier: String {
        return "CommonTableViewCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func configure() {
        self.backgroundColor = .clear
        //configure views
    }
}

//Register
extension BaseCollectionViewCell {
    class func registerWithNib(to collectionView: UICollectionView, nibName: String? = nil, identifier: String? = nil) {
        let nibName = nibName ?? self.className
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier ?? self.identifier)
    }
    
    class func register(to collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.identifier)
    }
}
