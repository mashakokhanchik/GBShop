//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

/// Протокол реализациии аутентификации личного кабинета.

protocol AuthRequestFactory {
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func registration(userName data: User,
                      completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
    
    func getUserData(userId: Int,
                     completionHandler: @escaping (AFDataResponse<GetUserDataResult>) -> Void)
    
    func changeUserData(userName data: User,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
    
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)

}
