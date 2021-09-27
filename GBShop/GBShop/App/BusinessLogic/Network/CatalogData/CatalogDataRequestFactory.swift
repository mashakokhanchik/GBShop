//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 17.08.2021.
//

import Foundation
import Alamofire

///Протокол получения списка товаров.

protocol CatalogDataRequestFactory {
    
    func getCatalogData(pageNumber: String,
                        idCategory: String,
                        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void)

}
