//
//  TinyNetwork+URL.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

/*
 Notice:
    We could have included all the tests in one unified method.
    But, in my opinion.., it's more readable (on failure case) to separate them.
 */

extension TinyNetworkTests {
    func testThatWillReceiveAnErrorWhenURLIsWrong() {
        // Given
        expectation = XCTestExpectation(description: "Request should handle an error when the URL provided is wrong")
        
        MockBadURLRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidUrl)
    }
    
    func testThatWillReceiveAnErrorWhenURLIsEmpty() {
        // Given
        expectation = XCTestExpectation(description: "Request should handle an error when the URL provided is empty")
        
        MockURLEmptyRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidUrl)
    }

    func testThatWillReceiveAnErrorWhenURLIsFilledWithWhiteSpace() {
        // Given
        expectation = XCTestExpectation(description: "Request should handle an error when the URL provided is filled with white spaces")
        
        MockURLWhiteSpacedRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidUrl)
    }

    func testThatWillReceiveAnErrorWhenURLIsFileSystemScheme() {
        // Given
        expectation = XCTestExpectation(description: "Request should handle an error when the URL provided is a file system scheme")
        
        MockFileSystemURLRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidUrl)
    }

    func testThatWillReceiveAnErrorWhenURLContainsIncorrectScheme() {
        // Given
        expectation = XCTestExpectation(description: "Request should handle an error when the URL contains an incorrect scheme")
        
        MockNotAllowedURLSchemeRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidUrl)
    }

}
