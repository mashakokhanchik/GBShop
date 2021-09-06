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

struct ChangeUserDataResult: Codable {
    
    let result: Int

}

struct LogoutResult: Codable {
    
    let result: Int

}

