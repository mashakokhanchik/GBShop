//
//  Reviews.swift
//  GBShop
//
//  Created by Мария Коханчик on 05.09.2021.
//

import Foundation
import Alamofire

/// Реализация протокола работы с  отзывами о товаре.

class Reviews: AbstractRequestFactory {
    
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

// MARK: - Reviews functions

extension Reviews: ReviewsRequestFactory {
    
    /// Получение списка отзывов о товаре
    
    func getReview(pageNumber: String,
                   completionHandler: @escaping (AFDataResponse<GetReviewResult>) -> Void) {
        let requestModel = GetReview(baseUrl: baseUrl,
                                     pageNumber: pageNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Добавление отзыва о товаре
    
    func addReview(userId: Int,
                   userReview: String,
                   completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReview(baseUrl: baseUrl,
                                     userId: userId,
                                     userReview: userReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Удаление отзыва о товаре
    
    func removeReview(idReview: Int,
                      removeMessage: String,
                      completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReview(baseUrl: baseUrl,
                                        idReview: idReview,
                                        removeMessage: removeMessage)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

// MARK: - Reviews structs

extension Reviews {
    
    /// Параметры и путь к запросу получения списка отзывов о товаре.
    
    struct GetReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getReview"
        
        let pageNumber: String
        var parameters: Parameters? {
            return ["pageNumber": pageNumber]
        }
    
    }
    
    /// Параметры и путь к запросу добавления отзыва о товаре.
    
    struct AddReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let userId: Int
        let userReview: String
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userReview": userReview]
        }
    
    }
    
    /// Параметры и путь к запросу удаления отзыва о товаре.
    
    struct RemoveReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeReview"
        
        let idReview: Int
        let removeMessage: String
        var parameters: Parameters? {
            return [
                "idReview": idReview,
                "removeMessage": removeMessage]
        }
    
    }

}
