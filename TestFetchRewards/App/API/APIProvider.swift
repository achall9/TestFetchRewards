//
//  APIProvider.swift
//  TestFetchRewards
//
//  Created by Alex on 26/07/2021.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

final class APIProvider<Target> where Target: Moya.TargetType {
    private let provider: MoyaProvider<Target>
    
    public init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
                stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
                callbackQueue: DispatchQueue? = nil,
                session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false) {
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Single<Moya.Response> {
        let request = provider.rx.request(token)
        return request
            .flatMap { response in
                let json = try? JSON(data: response.data)
                
                guard 200...299 ~= response.statusCode else {
                    if let error = AppError.parse(json: json) {
                        switch error {
                        case .invalidToken:
                            break
                            
                        case .tokenExpired:
                            return Single.error(AppError.tokenExpired).subscribeOn(MainScheduler.instance)
                        default:
                            break
                        }
                        UIManager.showAlert(message: error.localizedDescription)
                        return Single.error(error).subscribeOn(MainScheduler.instance)
                    }
                    else {
                        UIManager.showAlert(message: AppError.networkConnection.localizedDescription)
                        return Single.error(AppError.networkConnection).subscribeOn(MainScheduler.instance)
                    }
                }
                return Single.just(response)
            }
    }
}

extension AppError {
    static func parse(json: JSON?) -> AppError? {
        guard let json = json?.dictionary else { return nil }
        
        let errors = json["errors"] ?? json["error"]
        if let errors = errors {
            if let error = errors.rawValue as? String {
                if error == "invalid_request" {
                    return AppError.tokenExpired
                }
                return AppError.message(reason: errors.stringValue.firstCapitalized)
            }
            else {
                if  let error = errors.dictionary?.values.first {
                    if let content = error.arrayObject?.first as? String {
                        return AppError.message(reason: content.firstCapitalized)
                    }
                    else if let content = error.string {
                        return AppError.message(reason: content.firstCapitalized)
                    }
                }
            }
        }
        
        let message = json["message"] ?? json["messages"]
        if let message = message?.string {
            if message.lowercased().contains("unauthenticated") {
                return AppError.invalidToken
            }
            else {
                return AppError.message(reason: message.firstCapitalized)
            }
        }
        
        return nil
    }
}
