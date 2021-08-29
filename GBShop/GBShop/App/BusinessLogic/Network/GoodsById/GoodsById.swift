//
//  GoodsById.swift
//  GBShop
//
//  Created by Мария Коханчик on 22.08.2021.
//

import Foundation
import Alamofire

class GoodsById: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GoodsById: GoodsByIdRequestFactory {
    
    func getGoodsById(idProduct: String, completionHandler: @escaping (AFDataResponse<GoodsByIdResult>) -> Void) {
        let requestModel = GoodsByIdRequest(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GoodsById {
    
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
