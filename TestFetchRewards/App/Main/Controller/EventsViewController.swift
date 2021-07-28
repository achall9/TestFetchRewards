//
//  EventsViewController.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class EventsViewController: BaseViewController {
    @IBOutlet weak var tblEvents: UITableView!
    
    fileprivate var events = BehaviorRelay<[Event]>(value: [])
    fileprivate var allEvents = [Event]()

    override func configureUI() {
        super.configureUI()
        
        self.title = "Events"
        navigationItem.searchController = SearchController(delegate: self)
        self.definesPresentationContext = true
        EventCell.registerWithNib(to: tblEvents)
    }
    
    override func setupRx() {
        super.setupRx()
        
        events.bind(to: tblEvents.rx.items(cellIdentifier: EventCell.identifier, cellType: EventCell.self)) { row, event, cell in
            cell.reset(event)
        }.disposed(by: disposeBag)
        
        tblEvents.rx.modelSelected(Event.self).asSignal().debug().emit(onNext: { event in
            self.showEventDetail(event)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppearFirstTime() {
        super.viewWillAppearFirstTime()
        loadEvents()
    }
    
    fileprivate func loadEvents(_ searchKey:String? = nil) {
        Event.get(searchKey).observeOn(MainScheduler.asyncInstance).subscribe { events in
            self.eventsLoaded(events)
        } onError: { [weak self] error in
            self?.isLoading = false
        }.disposed(by: disposeBag)
    }
    
    fileprivate func eventsLoaded(_ events: [Event]) {
        self.allEvents = events
        self.events.accept(events)
    }
    
    func showEventDetail(_ event:Event) {
        guard let controller = UIManager.loadViewController(storyboard: "Main", controller: "sid_event_details") as? EventDetailsViewController else {
            return
        }
        controller.event = event
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: UISearchResultsUpdating
extension EventsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        defer { tblEvents.reloadData() }
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            events.accept(allEvents)
            return
        }
        self.events.accept(allEvents.filter({$0.allText.lowercased().contains(searchText.lowercased())}))
    }
    
}

extension EventsViewController: FavoriteDelegate {
    func changedFavorite() {
        tblEvents.reloadData()
    }
}
