//
//  GoodsByIdRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 22.08.2021.
//

import Foundation
import Alamofire

/// Протокол получения отдельного товара.

protocol GoodsByIdRequestFactory {
    
    func getGoodsById(idProduct: String, completionHandler: @escaping(AFDataResponse<GoodsByIdResult>) -> Void)

}
