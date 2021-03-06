//
//  User.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation

struct User: Codable {
    
    let id: Int?
    let login: String?
    let lastname: String?
    let email: String?
    let password, newPassword: String?

}
