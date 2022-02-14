//
//  Basket.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation
import Alamofire

/// Реализация протокола работы с корзиной товаров.

class Basket: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility),
         baseUrl: URL
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }

}

// MARK: - Basket functions

extension Basket: BasketRequestFactory {
    
    func getBasket(userId: Int,
                   completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl,
                                     userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Добавление товара в корзину
    
    func addToBasket(productId: Int,
                     userId: Int,
                     quantity: Int,
                     completionHandler: @escaping(AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasket(baseUrl: baseUrl,
                                       productId: productId,
                                       userId: userId,
                                       quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Удаление товара из корзины.
    
    func deleteFromBasket(productId: Int,
                          userId: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasket(baseUrl: baseUrl,
                                            userId: userId,
                                            productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Очистка карзины.
    
    func clearBasket(userId: Int,
                     completionHandler: @escaping (AFDataResponse<ClearBasketResult>) -> Void) {
        let requestModel = ClearBasket(baseUrl: baseUrl,
                                       userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Списание денежных средств.
    
    func payBasket(userId: Int,
                   paySumm: Int,
                   completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl,
                                     userId: userId,
                                     paySumm: paySumm)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

// MARK: - Basket structs

extension Basket {
    
    struct GetBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"
        
        let userId: Int
        var parameters: Parameters? {
            return ["userId": userId]
        }
    }
    
    /// Параметры и путь к запросу добавления товара в корзину.
    
    struct AddToBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let productId: Int
        let userId: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "productId": productId,
                "userId": userId,
                "quantity": quantity]
        }
    
    }
    
    /// Параметры и путь к запросу удвления товара из корзины.
    
    struct DeleteFromBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let userId: Int
        let productId: Int
        var parameters: Parameters? {
            return [
                "userId": userId,
                "productId": productId]
        }
    
    }
    
    /// Параметры и путь к запросу об очистке корзины с товарами.
    
    struct ClearBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "clearBasket"
        
        let userId: Int
        var parameters: Parameters? {
            return ["uderId": userId]
        }
        
    }
    
    /// Параметры и путь к запросу на списание денежных средств.
    
    struct PayBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        
        let userId: Int
        let paySumm: Int
        var parameters: Parameters? {
            return [
                "userId": userId,
                "paySumm": paySumm]
        }
        
    }
    
}
