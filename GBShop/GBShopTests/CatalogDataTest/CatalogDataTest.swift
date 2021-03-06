//
//  CatalogDataTest.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 22.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class CatalogDataTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testCatalogData() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let catalogData = GoodsData(errorParser: ErrorParser(),
                                      sessionManager: session,
                                      baseUrl: baseUrl)
        
        let catalogDataExpectation = expectation(description: "Catalog data")
        catalogData.getCatalogData() { (response: AFDataResponse<CatalogDataResult>) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                catalogDataExpectation.fulfill()
            }
        }
        wait(for: [catalogDataExpectation], timeout: 5.0)
    }

}
