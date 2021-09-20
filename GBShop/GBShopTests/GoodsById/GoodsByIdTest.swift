//
//  GoodsByIdTest.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 22.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GoodsByIdTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testGoodsById() throws {
        
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let goodsById = GoodsById(errorParser: ErrorParser(),
                                  sessionManager: session,
                                  baseUrl: baseUrl)
        
        let goodsByIdExpectation = expectation(description: "Get goods by id")
        goodsById.getGoodsById(idProduct: "11") { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                goodsByIdExpectation.fulfill()
            }
        }
        wait(for: [goodsByIdExpectation], timeout: 5.0)
    }


}
