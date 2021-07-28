//
//  UITableViewExtension.swift
//
//  Created by Alex on 27/07/2021.
//


import UIKit

extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
//            let scrollPoint = CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height)
//            self.setContentOffset(scrollPoint, animated: true)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

extension UITableView {
  /**
   * Returns all IndexPath's in a table
   * ## Examples:
   * table.indexPaths.forEach {
   *    selectRow(at: $0, animated: true, scrollPosition: .none) // selects all cells
   * }
   */
  public var indexPaths: [IndexPath] {
     return (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [IndexPath] in
        (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> IndexPath? in
           IndexPath(row: rowIndex, section: sectionIndex)
        }
        }.flatMap { $0 }
  }
}

//Layout Header
extension UITableView {
    
    //Variable-height UITableView tableHeaderView with autolayout
    func layoutHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
