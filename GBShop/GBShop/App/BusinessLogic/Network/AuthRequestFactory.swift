//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    //func singin()
//    func changeUserData(oldData: User,
//                        newData: User,
//                        completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)//<ChangeUserDataResult>
//    func logout()
}
