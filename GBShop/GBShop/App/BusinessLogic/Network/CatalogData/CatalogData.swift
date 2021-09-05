//
//  CatalogData.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation
import Alamofire

class CatalogData: AbstractRequestFactory {
    
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

extension CatalogData: CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: String,
                        idCategory: String,
                        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl,
                                              pageNumber: pageNumber,
                                              idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
    
extension CatalogData {

    struct CatalogDataRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogData"
        
        let pageNumber: String
        let idCategory: String
        var parameters: Parameters? {
            return ["pageNumber": pageNumber,
                    "idCategory": idCategory]
        }
    }
    
}

