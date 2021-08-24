//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation

struct CatalogDataResult: Codable {
    
    let productId: Int
    let productName: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price = "price"
    }
}
