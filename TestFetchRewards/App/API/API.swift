//
//  APIManager.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import UIKit
import Alamofire
import ObjectMapper
import RxSwift
import Moya
import SwiftyJSON

enum AppError: Error {
    case unknown
    case networkConnection
    case tokenExpired
    case invalidToken
    case invalidJSON
    case message(reason: String)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "common_error".localized()
        case .networkConnection:
            return "network_connection_error".localized()
        case .invalidJSON:
            return "invalid_json_error".localized()
        case .invalidToken, .tokenExpired:
            return "invalid_token_error".localized()
        case .message(let reason): return reason
        }
    }
}

class API {
    static let shared = API()
    var provider: APIProvider<APIService>!
    var showHudEnabled: Bool = true
    
    init() {
        let loadPlugin = NetworkActivityPlugin { [weak self] (type, target) in
            guard let weak_self = self, let target = target as? APIService else {
                return
            }
            
            switch type {
            case .began:
                if weak_self.showHudEnabled, target.showHud {
                    ProgressHUD.show()
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            case .ended:
                if weak_self.showHudEnabled, target.showHud {
                    ProgressHUD.dismiss()
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        
        let timeout = { (endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) -> Void in
            if var urlRequest = try? endpoint.urlRequest() {
                urlRequest.timeoutInterval = 20
                closure(.success(urlRequest))
            } else {
                closure(.failure(MoyaError.requestMapping(endpoint.url)))
            }
        }
        
        self.provider = APIProvider<APIService>(requestClosure: timeout, plugins: [loadPlugin])
    }
    
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func filterSuccess() -> Single<Bool> {
        return flatMap { (response) -> Single<Bool> in
            return Single.just(true).subscribeOn(MainScheduler.instance)
        }
    }
    
    func filterResponse(filterData: Bool = true) -> Single<Element> {
        return flatMap { (response) -> Single<Element> in
            let json = try? JSON(data: response.data)
            if filterData {
                if let dict = json?.dictionary, let data = try? dict["events"]?.rawData() {
                    return Single.just(Response(statusCode: response.statusCode, data: data)).subscribeOn(MainScheduler.instance)
                }
                return Single.error(AppError.unknown).subscribeOn(MainScheduler.instance)
            }
            else {
                return Single.just(response).subscribeOn(MainScheduler.instance)
            }
        }
    }
}

//extension Response {
//    func mapModel(_ type: T.Type) throws->T {
//        let jsonString = String(data: data, encoding: .utf8)
//        guard let model = JSONDeserializer.deserializeFrom(json: jsonString) else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return model
//    }
//}
//
//extension MoyaProvider {
//    @discardableResult
//    open func request(_ target:Target, model: T.Type, completion: ((_ returnData: T?) -> Void)? ) -> Cancellable? {
//        return request(target, completion: { (result) in
//            guard let completion = completion else { return }
//            guard let returnData = try? result.value?.mapModel( ResponseData.self ) else {
//                completion(nil)
//                return
//            }
//            completion(returnData.data?.returnData)
//        })
//    }
//}
