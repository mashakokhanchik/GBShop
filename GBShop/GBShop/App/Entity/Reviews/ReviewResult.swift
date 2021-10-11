//
//  ReviewResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 05.09.2021.
//

import Foundation

typealias GetReviewListResult = [Review]

struct AddReviewResult: Codable {
    
    let result: Int
    let userMessage: String

}

struct ApproveReviewResult: Codable {
    
    let result: Int

}

struct RemoveReviewResult: Codable {
    
    let result: Int

}
