//
//  GoodsById.swift
//  GBShop
//
//  Created by Мария Коханчик on 22.08.2021.
//

import Foundation
import Alamofire

///Реализация протокола получения отдельного товара.

class GoodsById: AbstractRequestFactory {
   
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

extension GoodsById: GoodsByIdRequestFactory {
    
    //Получение отдельного товара
    
    func getGoodsById(idProduct: String, completionHandler: @escaping (AFDataResponse<GoodsByIdResult>) -> Void) {
        let requestModel = GoodsByIdRequest(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GoodsById {
    
    //Параметры и путь к запросу получения отдельного товара.
    
    struct GoodsByIdRequest: RequestRouter {

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getGoodById"
    
        let idProduct: String
        var parameters: Parameters? {
        return ["idProduct": idProduct]
        }
    }

}
