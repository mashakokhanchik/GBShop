//
//  BasketResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation

struct GetBasketResult: Codable {
    
    let amount: Int
    let itemsCount: Int
    let basketItems: [BasketItems]
    
}

struct BasketItems: Codable {
    
    let productId: Int
    let productName: String
    let productPrice: Int
    let quantity: Int
    
}

struct AddToBasketResult: Codable {
    
    let result: Int
    
}

struct DeleteFromBasketResult: Codable {
    
    let result: Int
    
}

struct ClearBasketResult: Codable {
    
    let result: Int
    let userMessage: String
    
}

struct PayBasketResult: Codable {
    
    let result: Int
    let userMessage: String
    
}
