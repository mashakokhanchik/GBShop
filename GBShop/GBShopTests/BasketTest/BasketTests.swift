//
//  BasketTests.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 20.09.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class BasketTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Add to basket test

    func testAddToBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let basket = Basket(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseUrl: baseUrl)
        
        let basketExpectation = expectation(description: "Add to basket")
        basket.addToBasket(productId: 1, userId: 1, quantity: 1) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                basketExpectation.fulfill()
            }
        }
        wait(for: [basketExpectation], timeout: 5.0)
    }
    
    // MARK: - Delete from basket test
    
    func testDeleteFromBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let basket = Basket(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseUrl: baseUrl)
        
        let basketExpectation = expectation(description: "Delete from basket")
        basket.deleteFromBasket(productId: 1, userId: 1) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                basketExpectation.fulfill()
            }
        }
        wait(for: [basketExpectation], timeout: 5.0)
    }
    
    // MARK: - Pay basket test
    
    func testPayBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let basket = Basket(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseUrl: baseUrl)
        
        let basketExpectation = expectation(description: "Pay basket")
        basket.payBasket(userId: 1, paySumm: 1) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                basketExpectation.fulfill()
            }
        }
        wait(for: [basketExpectation], timeout: 5.0)
    }

}
