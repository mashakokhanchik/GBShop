//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.09.2021.
//

import Foundation
import Alamofire

///Протокол работы с корзиной магазина.

protocol BasketRequestFactory {
    
    func addToBasket(idProduct: Int,
                     userId: Int,
                     quantity: Int,
                     completionHandler: @escaping(AFDataResponse<AddToBasketResult>) -> Void)
    
    func deleteFromBasket(idProduct: Int,
                          completionHandler: @escaping(AFDataResponse<DeleteFromBasketResult>) -> Void)
    
    func payBasket(userId: Int,
                   userMessage: String,
                   completionHandler: @escaping(AFDataResponse<PayBasketResult>) -> Void)
    
}

