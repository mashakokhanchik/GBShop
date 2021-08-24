//
//  RequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

class RequestFactory {

//Перенесла данные URL, еще разбираюсь как исправить baseUrl!
    
    lazy var baseUrl: URL? = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "raw.githubusercontent.com"
    components.path = "/GeekBrainsTutorial/online-store-api/master/responses/"
    return components.url
    }()
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuretion = URLSessionConfiguration.default
        configuretion.httpShouldSetCookies = false
        configuretion.headers = .default
        let manager = Session(configuration: configuretion)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser,
                    sessionManager: commonSession,
                    queue: sessionQueue,
                    baseUrl: baseUrl!)
    }
    
    func makeCatalogDataRequestFactory() -> CatalogDataRequestFactory {
        let errorParser = makeErrorParser()
        return CatalogData(errorParser: errorParser,
                           sessionManager: commonSession,
                           queue: sessionQueue,
                           baseUrl: baseUrl!)
    }
    
    func makeGoodsByIdFactory() -> GoodsByIdRequestFactory {
        let errorParser = makeErrorParser()
        return GoodsById(errorParser: errorParser,
                         sessionManager:commonSession,
                         queue: sessionQueue,
                         baseUrl: baseUrl!)
    }
    
}
