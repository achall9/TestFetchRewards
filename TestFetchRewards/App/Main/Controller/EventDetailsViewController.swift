//
//  EventDetailsViewController.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit

protocol FavoriteDelegate {
    func changedFavorite()
}
class EventDetailsViewController: BaseViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var event:Event?
    var delegate:FavoriteDelegate?
    
    override func configureUI() {
        super.configureUI()
        
        guard let event = self.event else { return }
        logoImageView.loadImage(url: event.imageUrl)
        titleLbl.text = event.short_title ?? event.title
        addressLbl.text = event.venue?.address
        timeLbl.text = event.datetime_local?.string(withFormat: "EEEE, dd MMM yyyy hh:mma")
        
        reloadFavoriteButton()
    }
    
    fileprivate func reloadFavoriteButton() {
        guard let id = event?.stringId else { return }
        self.favoriteBtn.tintColor = FavoriteManager.shared.favoriteShow[id] == true ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.1764705882, green: 0.2431372549, blue: 0.3098039216, alpha: 1)
        self.favoriteBtn.setImage(UIImage(systemName: FavoriteManager.shared.favoriteShow[id] == true ? "heart.fill" : "heart"), for: .normal)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        guard let id = event?.stringId else { return }
        FavoriteManager.shared.favoriteShow[id] = !(FavoriteManager.shared.favoriteShow[id] ?? false)
        reloadFavoriteButton()
        if let delegate = self.delegate {
            delegate.changedFavorite()
        }
    }
    
}
