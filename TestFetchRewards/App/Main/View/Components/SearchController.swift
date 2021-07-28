//
//  SearchController.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit

class SearchController: UISearchController {
    
    init(delegate: EventsViewController) {
        super.init(searchResultsController: nil)
        searchResultsUpdater = delegate
        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = false
        searchBar.placeholder = "Search Events"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
