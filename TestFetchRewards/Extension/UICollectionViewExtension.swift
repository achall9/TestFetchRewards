//
//  UICollectionViewExtension.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

let custom_collection_view_header_tag = 1000
extension UICollectionView {
    var currentCustomHeaderView: UIView? {
        return self.viewWithTag(custom_collection_view_header_tag)
    }

    func asssignCustomHeaderView(headerView: UIView, sideMarginInsets: CGFloat = 0) {
        guard self.viewWithTag(custom_collection_view_header_tag) == nil else {
            return
        }
        
        headerView.layoutIfNeeded()
        let expectedWidth: CGFloat = UIScreen.main.bounds.width - (2 * sideMarginInsets)
        let desiredSize = CGSize(width: expectedWidth, height: UIScreen.main.bounds.height)
        let height = headerView.systemLayoutSizeFitting(desiredSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        headerView.frame = CGRect(x: sideMarginInsets, y: -height + self.contentInset.top, width: expectedWidth, height: height)
        headerView.tag = custom_collection_view_header_tag
        self.addSubview(headerView)
        self.contentInset = UIEdgeInsets(top: height, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
    }

    func removeCustomHeaderView() {
        if let customHeaderView = self.viewWithTag(custom_collection_view_header_tag) {
            let headerHeight = customHeaderView.frame.height
            customHeaderView.removeFromSuperview()
            self.contentInset = UIEdgeInsets(top: self.contentInset.top - headerHeight, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }
}
