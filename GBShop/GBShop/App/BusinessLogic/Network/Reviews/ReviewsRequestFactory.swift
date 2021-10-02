//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 05.09.2021.
//

import Foundation
import Alamofire

/// Протокол работы с отзывами о товаре.

protocol ReviewsRequestFactory {
    
    func getReview(pageNumber: String,
                   completionHandler: @escaping(AFDataResponse<GetReviewResult>) -> Void)
    
    func addReview(userId: Int,
                   userReview: String,
                   completionHandler: @escaping(AFDataResponse<AddReviewResult>) -> Void)
    
    func removeReview(idReview: Int,
                      removeMessage: String,
                      completionHandler: @escaping(AFDataResponse<RemoveReviewResult>) -> Void)

}
