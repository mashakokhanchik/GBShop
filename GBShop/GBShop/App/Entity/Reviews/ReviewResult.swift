//
//  ReviewResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 05.09.2021.
//

import Foundation

struct GetReviewResult: Codable {
    
    let result: Int
    let reviews: Review

}

struct AddReviewResult: Codable {
    
    let result: Int
    let userReview: String

}

struct RemoveReviewResult: Codable {
    
    let result: Int
    let removeMessage: String

}
