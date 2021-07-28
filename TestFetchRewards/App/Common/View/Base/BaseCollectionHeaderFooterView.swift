//
//  BaseCollectionHeaderFooterView.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

class BaseCollectionHeaderFooterView: UICollectionReusableView {
    class var identifier: String {
        return "base_collection_header_footer"
    }
    
    class var height: CGFloat {
        return 50
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
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
    }
}

extension BaseCollectionHeaderFooterView {
    class func registerWithNib(to collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader, nibName: String? = nil) {
        let nibName = nibName ?? self.className
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.identifier)
    }
    
    class func register(to collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader) {
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.identifier)
    }
}
