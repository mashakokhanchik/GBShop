//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation
import Alamofire

/// Протокол получения списка товаров, отдельного товара.

protocol GoodsRequestFactory {
    
    func getCatalogData(completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void)
    
    func getGoodsById(idProduct: String, completionHandler: @escaping(AFDataResponse<GoodsByIdResult>) -> Void)

}
