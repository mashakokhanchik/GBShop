//
//  AppSession.swift
//  GBShop
//
//  Created by Мария Коханчик on 24.09.2021.
//

import Foundation

class AppSession {
    
    // MARK: - Properties
    
    static var shared = AppSession()
    private(set) var userInfo: User?
    private(set) var productInfo: GoodsByIdResult?
    var currentUserId: Int? { return userInfo?.id }
    var currentProductId: Int? { return productInfo?.productId }
    
    // MARK: - Methods
    
    func setUserInfo(_ info: User) {
        self.userInfo = info
    }

    func killUserInfo() {
        self.userInfo = nil
    }
    
    func setProductInfo(_ info: GoodsByIdResult) {
        self.productInfo = info
    }

}


