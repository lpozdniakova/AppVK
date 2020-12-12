//
//  LoginWithAssertionsUITests.swift
//  AppForVKUITests
//
//  Created by Lyudmila on 07.12.2020.
//  Copyright © 2020 Семериков Михаил. All rights reserved.
//

import XCTest

class LoginWithAssertionsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLoginWithAssertions() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Enter login
        var phoneOrEmailField: XCUIElement {
            app.otherElements.containing(.staticText, identifier: "Phone or email:").descendants(matching: .textField).firstMatch
        }
        XCTAssertTrue(phoneOrEmailField.waitForExistence(timeout: 1))
        phoneOrEmailField.tap()
        phoneOrEmailField.typeText(User().email)
        
        // Enter password
        var passwordField: XCUIElement {
            app.otherElements.containing(.staticText, identifier: "Password:").descendants(matching: .secureTextField).firstMatch
        }
        XCTAssertTrue(passwordField.waitForExistence(timeout: 1))
        passwordField.tap()
        for char in User().password {
            app.keys["\(char)"].tap()
        }
        
        // Tap Log in button
        var logInButton: XCUIElement {
            app.buttons["Log in"]
        }
        passwordField.swipeUp()
        XCTAssertTrue(logInButton.exists() && logInButton.isHittable())
        logInButton.tap()
    }
}

struct User {
    var email = "alice@test.test"
    var password = "qaws"
}

