//
//  BasketResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation

struct AddToBasketResult: Codable {
    
    let result: Int
    
}

struct DeleteFromBasketResult: Codable {
    
    let result: Int
    
}

struct PayBasketResult: Codable {
    
    let result: Int
    let userMessage: String
    
}
