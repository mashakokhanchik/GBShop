//
//  ReviewsTest.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 19.09.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ReviewsTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Get review test

    func testGetReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let review = Reviews(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseUrl: baseUrl)
        
        let reviewExpectation = expectation(description: "To get review")
        review.getReview(productId: 1) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                reviewExpectation.fulfill()
            }
        }
        wait(for: [reviewExpectation], timeout: 5.0)
    }
    
    // MARK: - Add review test

    func testAddReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let review = Reviews(errorParser: ErrorParser(),
                             sessionManager: session,
                             baseUrl: baseUrl)
        
        let addReviewModel = Review(idReview: nil,
                                    productId: 1,
                                    login: "Somebody",
                                    email: "some@some.ru",
                                    title: "Some title",
                                    textReview: "Some text")
        
        let reviewExpectation = expectation(description: "To add review")
        review.addReview(productId: 1, review: addReviewModel) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                reviewExpectation.fulfill()
            }
        }
        wait(for: [reviewExpectation], timeout: 5.0)
    }
    
    // MARK: - Remove review
    
    func testRemoveReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let review = Reviews(errorParser: ErrorParser(),
                            sessionManager: session,
                            baseUrl: baseUrl)
        
        let reviewExpectation = expectation(description: "To remove review")
        review.removeReview(idReview: 1) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                reviewExpectation.fulfill()
            }
        }
        wait(for: [reviewExpectation], timeout: 5.0)
    }
    
}
