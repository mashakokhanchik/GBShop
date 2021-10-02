//
//  AuthTest.swift
//  GBShopTests
//
//  Created by Мария Коханчик on 22.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // MARK: - Login test
    
    func testLogin() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let auth = Auth(errorParser: ErrorParser(),
                        sessionManager: session,
                        baseUrl: baseUrl)
        
        let authExpectation = expectation(description: "To enter")
        auth.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                authExpectation.fulfill()
            }
        }
        wait(for: [authExpectation], timeout: 5.0)
    }

    // MARK: - Registration Test
    
//    func testRegistration() throws {
//        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false
//        configuration.headers = .default
//        let session = Session(configuration: configuration)
//        
//        let auth = Auth(errorParser: ErrorParser(),
//                        sessionManager: session,
//                        baseUrl: baseUrl)
//        
//        let registrationExpectation = expectation(description: "Registration")
//        auth.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru") { response in
//            switch response.result {
//            case .success(let model):
//                XCTFail("Fail: \(model)")
//            case .failure:
//                registrationExpectation.fulfill()
//            }
//        }
//        wait(for: [registrationExpectation], timeout: 5.0)
//    }

    // MARK: - Change user data test
    
//    func testChangeUserData() throws {
//        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false
//        configuration.headers = .default
//        let session = Session(configuration: configuration)
//        
//        let auth = Auth(errorParser: ErrorParser(),
//                        sessionManager: session,
//                        baseUrl: baseUrl)
//        
//        let changeUserDataExpectation = expectation(description: "Change user data")
//        auth.changeUserData(userName: "Somebody") { response in
//            switch response.result {
//            case .success(let model):
//                XCTFail("Fail: \(model)")
//            case .failure:
//                changeUserDataExpectation.fulfill()
//            }
//        }
//        wait(for: [changeUserDataExpectation], timeout: 5.0)
//    }

    // MARK: - Logout test
    
    func testLogout() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://failUrl"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let auth = Auth(errorParser: ErrorParser(),
                        sessionManager: session,
                        baseUrl: baseUrl)
        
        let logoutExpectation = expectation(description: "Logout")
        auth.logout(userId: 55) { response in
            switch response.result {
            case .success(let model):
                XCTFail("Fail: \(model)")
            case .failure:
                logoutExpectation.fulfill()
            }
        }
        wait(for: [logoutExpectation], timeout: 5.0)
    }
    
}
        
        
        
    
    

