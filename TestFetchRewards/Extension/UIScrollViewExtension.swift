//
//  UIScrollViewExtension.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
