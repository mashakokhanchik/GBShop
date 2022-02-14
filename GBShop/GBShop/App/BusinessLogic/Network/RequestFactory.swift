//
//  RequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire
import Swinject

class RequestFactory {
    
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
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser() }
        container.register(Auth.self) { resolver in
            Auth(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                 sessionManager: self.commonSession,
                 baseUrl: self.baseUrl!)
        }
        return container.resolve(Auth.self)!
    }
    
    func makeGoodsDataRequestFactory() -> GoodsRequestFactory {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser() }
        container.register(GoodsData.self) { resolver in
            GoodsData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                 sessionManager: self.commonSession,
                 baseUrl: self.baseUrl!)
        }
        return container.resolve(GoodsData.self)!
    }
    
    
    func makeReviewsRequestFactory() -> ReviewsRequestFactory {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser() }
        container.register(Reviews.self) { resolver in
            Reviews(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                    sessionManager: self.commonSession,
                    baseUrl: self.baseUrl!)
        }
        return container.resolve(Reviews.self)!
    }
    
    func makeBasketFactory() -> BasketRequestFactory {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser() }
        container.register(Basket.self) { resolver in
            Basket(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                   sessionManager: self.commonSession,
                   baseUrl: self.baseUrl!)
        }
        return container.resolve(Basket.self)!
    }
    
}
