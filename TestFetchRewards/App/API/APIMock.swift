//
//  APIMock.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import Foundation
import RxSwift

class APIMock {
    static let shared = APIMock()
}

extension APIMock {
    func getEvents() -> Observable<[Event]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func getPerformers() -> Observable<[Performer]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func getVenues() -> Observable<[Venue]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
