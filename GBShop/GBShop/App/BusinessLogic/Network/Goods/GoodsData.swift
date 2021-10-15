//
//  GoodsData.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation
import Alamofire

///Реализация протокола получения списка товаров, отдельного товара.

class GoodsData: AbstractRequestFactory {
    
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

extension GoodsData: GoodsRequestFactory {

    ///Получение списка товаров
    
    func getCatalogData(completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Получение отдельного товара
    
    func getGoodsById(idProduct: Int, completionHandler: @escaping (AFDataResponse<GoodsByIdResult>) -> Void) {
        let requestModel = GoodsByIdRequest(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
    
extension GoodsData {
    
    /// Параметры и путь к запросу для получения списка товаров.

    struct CatalogDataRequest: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogData"
        
        var parameters: Parameters?
    
    }
    
    /// Параметры и путь к запросу получения отдельного товара.
    
    struct GoodsByIdRequest: RequestRouter {

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getGoodById"
    
        let idProduct: Int
        var parameters: Parameters? {
        return ["idProduct": idProduct]
        }
    
    }
    
}

