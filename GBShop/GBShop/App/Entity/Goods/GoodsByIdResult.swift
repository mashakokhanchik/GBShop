//
//  GoodsByIdResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 22.08.2021.
//

import Foundation

struct GoodsByIdResult: Codable {
    
    let result: Int
    let productId: Int
    let productName: String
    let price: Int
    let productImage: String
    let description: String

}
