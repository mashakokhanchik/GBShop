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
    
    func getReview(productId: Int,
                   completionHandler: @escaping (AFDataResponse<GetReviewListResult>) -> Void) {
        let requestModel = GetListReview(baseUrl: baseUrl,
                                     productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Добавление отзыва о товаре
    
    func addReview(productId: Int,
                   review: Review,
                   completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReview(baseUrl: baseUrl,
                                     productId: productId,
                                     idReview: review.idReview,
                                     login: review.login,
                                     email: review.email,
                                     title: review.title,
                                     textReview: review.textReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func setReviewApprove(idReview: Int,
                          completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void) {
        let requestModel = ApproveReview(baseUrl: baseUrl,
                                         idReview: idReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Удаление отзыва о товаре
    
    func removeReview(idReview: Int,
                      completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReview(baseUrl: baseUrl,
                                        idReview: idReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

// MARK: - Reviews structs

extension Reviews {
    
    /// Параметры и путь к запросу получения списка отзывов о товаре.
    
    struct GetListReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getListReview"
        
        let productId: Int
        var parameters: Parameters? {
            return ["pageNumber": productId]
        }
    
    }
    
    /// Параметры и путь к запросу добавления отзыва о товаре.
    
    struct AddReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        let productId: Int
        let idReview: Int?
        let login: String
        let email: String
        let title: String
        let textReview: String
        var parameters: Parameters? {
            return [
                "productId": productId,
                "idReview": idReview ?? 0,
                "login": login,
                "email": email,
                "title": title,
                "textReview": textReview]
        }
    
    }
    
    struct ApproveReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "approveReview"
        
        let idReview: Int
        var parameters: Parameters? {
            return [
                "idReview": idReview]
        }
    }
    
    /// Параметры и путь к запросу удаления отзыва о товаре.
    
    struct RemoveReview: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeReview"
        
        let idReview: Int
        var parameters: Parameters? {
            return [
                "idReview": idReview]
        }
    
    }

}
