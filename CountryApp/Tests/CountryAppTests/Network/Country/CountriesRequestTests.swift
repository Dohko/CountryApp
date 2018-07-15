//
//  CountriesRequestTests.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

class CountriesRequestTests: NetworkBaseTest {
    
    func testThatSuccessWithGoodResponse() {
        // Given
        expectation = XCTestExpectation(description: "should parse and decode the response")
        let data = contentFile(named: "countries")

        // When
        MockCountriesRequest(data: data, error: nil).request(handler:  handler!)
        wait(for: [expectation!], timeout: 10.0)
        let countriesData = response as? Countries

        // Then
        XCTAssertNil(error)
        XCTAssertNotNil(countriesData)
        XCTAssertFalse(countriesData!.countries.isEmpty)
    }

    func testThatFailedWithWrongDataResponse() {
        // Given
        expectation = XCTestExpectation(description: "should not parse and decode incorrect data")
        let data = Data("{\"foo\": \"bar\"}".utf8)
        
        // When
        MockCountriesRequest(data: data, error: nil).request(handler:  handler!)
        wait(for: [expectation!], timeout: 10.0)

        // Then
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.decoding)
        XCTAssertNil(response)
    }

}
