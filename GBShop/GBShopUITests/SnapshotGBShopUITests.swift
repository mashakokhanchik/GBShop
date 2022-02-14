//
//  SnapshotGBShopUITests.swift
//  GBShopUITests
//
//  Created by Мария Коханчик on 31.10.2021.
//

import XCTest

class SnapshotGBShopUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
//        snapshot("loginScreen")
//        app.textFields["username"].tap()
//        app.textFields["username"].typeText("test")
//        let passwordSecureTextField = app.secureTextFields["password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("test")
//        app.buttons["Войти"].tap()
//
//        snapshot("basketScreen")
    }

}
