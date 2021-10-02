//
//  ErrorParser.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation

///Реализация протокола обработки ошибок.

class ErrorParser: AbstractErrorParser {
    
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
}
