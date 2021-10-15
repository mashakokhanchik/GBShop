//
//  Review.swift
//  GBShop
//
//  Created by Мария Коханчик on 05.09.2021.
//

import Foundation

struct Review: Codable {
    
    let idReview: Int?
    let productId: Int?
    let login: String
    let email: String
    let title: String
    let textReview: String

}
