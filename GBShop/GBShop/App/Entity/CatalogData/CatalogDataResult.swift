//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation

struct CatalogDataResult: Codable {
    
    let pageNumber: Int
    let products: [Product]
    
//    enum CodingKeys: String, CodingKey {
//        case psgeNumber = "page_number"
//        case products
//    }
}
