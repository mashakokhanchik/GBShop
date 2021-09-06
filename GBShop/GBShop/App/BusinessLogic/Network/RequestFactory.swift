//
//  RequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
/*Если URL разбиваю на компоненты, то в функциях всё равно ипользую !, решение проблемы пока не нашла.
Как провильно вынести baseUrl в Core-слой тоже пока не разобралась.*/

//    lazy var baseUrl = URL(string: "https://protected-bayou-45049.herokuapp.com")!
    
    lazy var baseUrl: URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "protected-bayou-45049.herokuapp.com"
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
    
    func makeReviewsFactory() -> ReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser,
                       sessionManager: commonSession,
                       queue: sessionQueue,
                       baseUrl: baseUrl!)
    }
    
}
