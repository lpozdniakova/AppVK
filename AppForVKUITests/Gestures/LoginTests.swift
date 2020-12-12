//
//  LoginTests.swift
//  LoginTests
//
//  Created by Lyudmila on 07.12.2020.
//  Copyright © 2020 Семериков Михаил. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Enter login
        var phoneOrEmailField: XCUIElement {
            app.otherElements.containing(.staticText, identifier: "Phone or email:").descendants(matching: .textField).firstMatch
        }
        phoneOrEmailField.tap()
        phoneOrEmailField.typeText(User().email)
        
        // Enter password
        var passwordField: XCUIElement {
            app.otherElements.containing(.staticText, identifier: "Password:").descendants(matching: .secureTextField).firstMatch
        }
        passwordField.tap()
        for char in User().password {
            app.keys["\(char)"].tap()
        }
        
        // Tap Log in button
        var logInButton: XCUIElement {
            app.buttons["Log in"]
        }
        passwordField.swipeUp()
        logInButton.tap()
    }
}

struct User {
    var email = "alice@test.test"
    var password = "qaws"
}
