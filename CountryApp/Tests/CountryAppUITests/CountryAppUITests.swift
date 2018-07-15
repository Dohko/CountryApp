//
//  CountryAppUITests.swift
//  CountryAppUITests
//
//  Created by Morgan Fitussi on 14/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

class CountryAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }
    
    func testThatCountriesViewControllerIsDisplayed() {
        let tableView = app.tables["CountriesTable"]
        XCTAssertTrue(tableView.cells.count > 0)
    }
    
}
