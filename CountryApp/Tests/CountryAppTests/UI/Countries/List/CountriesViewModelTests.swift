//
//  CountriesViewModelTests.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

class CountriesViewModelTests: BaseTest {
    
    func testThatTheListHasBeenReloaded() {
        // Given
        expectation = XCTestExpectation(description: "should reload the list")
        let data = contentFile(named: "countries")
        let viewModel = MokeCountriesViewModel(data: data, error: nil)
        var isReloaded = false
        viewModel.reloadTable = { [weak self]() in
            isReloaded = true
            self?.expectation?.fulfill()
        }
        
        // When
        viewModel.request()
        wait(for: [expectation!], timeout: 10.0)

        // Then
        XCTAssertTrue(isReloaded)
    }

    func testHandleError() {
        // Given
        expectation = XCTestExpectation(description: "should handle a connexion error")
        let viewModel = MokeCountriesViewModel(data: nil, error: Network.NetworkError.invalidRequest)
        var error: Error? = nil
        viewModel.requestFailed = { [weak self](err) in
            error = err
            self?.expectation?.fulfill()
        }

        // When
        viewModel.request()
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidRequest)

    }
    
}
