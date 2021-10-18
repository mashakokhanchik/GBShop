//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Мария Коханчик on 03.08.2021.
//

import XCTest

class GBShopUITests: XCTestCase {
    
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        scrollViewsQuery = app.scrollViews
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        enterAuthData(login: "admin", password: "123456")
        let resultLabel = scrollViewsQuery.staticTexts["Данные верны"]
        XCTAssertNotNil(resultLabel)
    }
    
    func testFail() {
        enterAuthData(login: "user", password: "password")
        let resultLabel = scrollViewsQuery.staticTexts["Ошибка входа"]
        XCTAssertNotNil(resultLabel)
    }
    
    private func enterAuthData(login: String, password: String) {
        let loginTextField = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
        loginTextField.tap()
        loginTextField.typeText(login)
        
        let passwordTextField = scrollViewsQuery.children(matching: .textField).element(boundBy: 1)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        let button = scrollViewsQuery.buttons["Войти"]
        button.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
            }
        }
    }
}
