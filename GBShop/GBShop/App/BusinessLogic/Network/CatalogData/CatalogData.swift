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

extension CatalogData: CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: String,
                        idCategory: String,
                        completionHandler: @escaping (AFDataResponse<[CatalogDataResult]>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl,
                                              pageNumber: pageNumber,
                                              idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
    
extension CatalogData {

    struct CatalogDataRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: String
        let idCategory: String
        var parameters: Parameters? {
            return ["page_number": pageNumber,
                    "id_category": idCategory]
        }
    }
    
}

