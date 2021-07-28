//
//  EventCell.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//

import UIKit

class EventCell: BaseTableViewCell {
    override class var identifier: String {
        return "event_cell"
    }
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    func reset(_ event: Event) {
        logoImageView.loadImage(url: event.imageUrl)
        titleLbl.text = event.short_title ?? event.title
        addressLbl.text = event.venue?.address
        timeLbl.text = event.datetime_local?.string(withFormat: "EEEE, dd MMM yyyy hh:mma")
        
        self.heartImageView.isHidden = FavoriteManager.shared.favoriteShow[event.stringId] != true
        self.heartImageView.tintColor = FavoriteManager.shared.favoriteShow[event.stringId] == true ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.1764705882, green: 0.2431372549, blue: 0.3098039216, alpha: 1)
        self.heartImageView.image = UIImage(systemName: FavoriteManager.shared.favoriteShow[event.stringId] == true ? "heart.fill" : "heart")
    }
}
