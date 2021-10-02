//
//  Auth.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

/// Реализация протокола аутентификации личного кабинета.

class Auth: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility),
         baseUrl: URL
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }

}

// MARK: - Authentication functions

extension Auth: AuthRequestFactory {
    
    /// Выполнение входа пользователя
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl,
                                 login: userName,
                                 password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Регистрация пользоввателя
    
    func registration(userName data: User,
                      completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl,
                                        login: data.login ?? "",
                                        password: data.password ?? "",
                                        email: data.email ?? "")
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Изменение личных данных пользователя
    
    func changeUserData(userName data: User,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl,
                                          login: data.login ?? "",
                                          password: data.password ?? "",
                                          email: data.email ?? "")
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    /// Реализация выхода пользователя
    
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

// MARK: - Authentication structs

extension Auth {
    
    /// Параметры и путь к запросу входа пользователя в личный кабинет.
    
    struct Login: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return ["username": login,
                    "password": password]
        }
    
    }
    
    /// Параметры и путь к запросу на регистрацию пользователя.

    struct Registration: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "registration"
        
        let login: String
        let password: String
        let email: String
        var parameters: Parameters? {
            return ["username": login,
                    "password": password,
                    "email": email]
        }
    
    }
    
    /// Параетры и путь к запросу на изменение личных данных пользователя.
    
    struct ChangeUserData: RequestRouter{
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        
        let login: String
        let password: String
        let email: String
        var parameters: Parameters? {
            return ["username": login,
                    "password": password,
                    "email": email]
        }
    
    }
    
    /// Параметры и путь к запросу выхода пользователя из личного кабинета.
    
    struct Logout: RequestRouter {
        
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"
        
        let userId: Int
        var parameters: Parameters? {
            return ["userId": userId]
        }
    
    }

}
