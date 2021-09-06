//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

///Протокол реализациии аутентификации личного кабинета.

protocol AuthRequestFactory {
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func registration(userName: String,
                      password: String,
                      email: String,
                      completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
    
    func changeUserData(userName: String,
                        passord: String,
                        email: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
    
    func logout(userId: String,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)

}
