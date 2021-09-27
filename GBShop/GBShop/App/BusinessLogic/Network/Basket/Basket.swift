//
//  Basket.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation
import Alamofire

///Реализация протокола работы с корзиной товаров.

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
    
    ///Добавление товара в корзину
    
    func addToBasket(idProduct: Int,
                     quantity: Int,
                     completionHandler: @escaping(AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasket(baseUrl: baseUrl,
                                       idProduct: idProduct,
                                       quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    ///Удаление товара из корзины.
    
    func deleteFromBasket(idProduct: Int,
                          completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasket(baseUrl: baseUrl,
                                            idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    ///Списание денежных средств.
    
    func payBasket(userId: Int,
                   userMessage: String,
                   completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl,
                                     userId: userId,
                                     userMessage: userMessage)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

// MARK: - Basket structs

extension Basket {
    
    ///Параметры и путь к запросу добавления товара в корзину.
    
    struct AddToBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let idProduct: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "idProduct": idProduct,
                "quantity": quantity]
        }
    
    }
    
    ///Параметры и путь к запросу удвления товара из корзины.
    
    struct DeleteFromBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let idProduct: Int
        var parameters: Parameters? {
            return ["idProduct": idProduct]
        }
    
    }
    
    ///Параметры и путь к запросу на списание денежных средств.
    
    struct PayBasket: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        
        let userId: Int
        let userMessage: String
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userMessage": userMessage]
        }
        
    }
    
}
