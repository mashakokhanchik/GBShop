//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
