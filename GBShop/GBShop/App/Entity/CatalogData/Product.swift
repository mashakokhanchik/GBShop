//
//  Product.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation

struct Product: Codable {
    let id: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}
