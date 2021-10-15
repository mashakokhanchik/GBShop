//
//  ResponseCodableTest.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 17.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class ResponseCodableTest: XCTestCase {

    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser = ErrorParserStub()

    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = ErrorParserStub()
    }
    
    func testExample() throws {
        let errorParser = ErrorParserStub()
        AF
            /// Необходимо поменять https
            .request("https://failUrl")
            .responseCodable(errorParser: errorParser) { [weak self] (response: DataResponse<PostStub, AFError>) in
                switch response.result {
                case .success(_): break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                self!.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 5.0)
        }

}
