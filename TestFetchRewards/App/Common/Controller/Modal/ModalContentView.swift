//
//  ModalContentView.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

typealias ModalCompletion = (_ index: Int, _ data: Any?) -> Void

class ModalContentView: BaseCustomView {
    var completion: ModalCompletion? = nil
    
    override func build() {
        super.build()
        self.backgroundColor = .appAccent
    }
    
    @IBAction func onClose(_ sender: Any) {
        completion?(-1, nil)
    }
}
