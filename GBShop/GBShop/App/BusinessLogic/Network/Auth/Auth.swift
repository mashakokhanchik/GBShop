//
//  Auth.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080")!

//Если разбивать на компоненты, не могу получить ответ от сервера, выдает ошибку, ищу как исправить
    
    //    lazy var baseUrl: URL? = {
    //    var components = URLComponents()
    //    components.scheme = "https"
    //    components.host = "127.0.0.1:8080"//raw.githubusercontent.com"
    //    components.path = "registration"//"/GeekBrainsTutorial/online-store-api/master/responses/"
    //    return components.url
    //    }()
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

//MARK: - Authentication functions

extension Auth: AuthRequestFactory {
    
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl,
                                 login: userName,
                                 password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func registration(userName: String,
                      password: String,
                      email: String,
                      completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl,
                                        login: userName,
                                        password: password,
                                        email: email)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(userName: String,
                        passord: String,
                        email: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl,
                                          login: userName,
                                          password: passord,
                                          email: email)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: String,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

//MARK: - Authentication structs

extension Auth {
    
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
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"
        
        let userId: String
        var parameters: Parameters? {
            return ["userId": userId]
        }
    }
}