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
    
    func getReview(productId: Int,
                   completionHandler: @escaping(AFDataResponse<GetReviewListResult>) -> Void)
    
    func addReview(productId: Int,
                   review: Review,
                   completionHandler: @escaping(AFDataResponse<AddReviewResult>) -> Void)
    
    func setReviewApprove(idReview: Int,
                          completionHandler: @escaping(AFDataResponse<ApproveReviewResult>) -> Void)
    
    func removeReview(idReview: Int,
                      completionHandler: @escaping(AFDataResponse<RemoveReviewResult>) -> Void)

}
