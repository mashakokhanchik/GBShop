//
//  AuthResult.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation

struct LoginResult: Codable {
    
    let result: Int
    let user: User

}

struct RegistrationResult: Codable {
   
    let result: Int
    let userMessage: String

}

struct GetUserDataResult: Codable {
    
    let result: Int
    let userId: Int
    let login: String
    let lastname: String
    let email: String
    let password: String

}

struct ChangeUserDataResult: Codable {
    
    let result: Int

}

struct LogoutResult: Codable {
    
    let result: Int

}

