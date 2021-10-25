//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation
import Alamofire

/// Протокол работы с корзиной магазина.

protocol BasketRequestFactory {
    
    func getBasket(userId: Int,
                   completionHandler: @escaping(AFDataResponse<GetBasketResult>) -> Void)
    
    func addToBasket(productId: Int,
                     userId: Int,
                     quantity: Int,
                     completionHandler: @escaping(AFDataResponse<AddToBasketResult>) -> Void)
    
    func deleteFromBasket(productId: Int,
                          userId: Int,
                          completionHandler: @escaping(AFDataResponse<DeleteFromBasketResult>) -> Void)
    
    func clearBasket(userId: Int,
                     completionHandler: @escaping(AFDataResponse<ClearBasketResult>) -> Void)
    
    func payBasket(userId: Int,
                   paySumm: Int,
                   completionHandler: @escaping(AFDataResponse<PayBasketResult>) -> Void)
    
}

