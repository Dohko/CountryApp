//
//  TinyNetworkTests.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

/*
 Notice:
    Testing a network library is unconventional. We have to test in an open
    environment. We could possibly create a mock network class but then we would have to test
    the mock. Tested a ("a" not "with a"..) mock object is, in my opinion.. (that's just my opinion for sure),
    not a best practice.
    Alamofire has also chosen to truly test the connections on httpbin.org.
    https://github.com/Alamofire/Alamofire/blob/master/Tests/RequestTests.swift
    In our case, it should be better to outsourced TinyNetwork and create a library.
    Then we would only run the network tests OR the tests of the rest of the application.
    Another challenge is to simulate packet loss or disconnection without external handling, so actually
    our options include:
    - Network Link Conditioner: could be find on Apple download center
    - Run the unit tests on Airplane mode
 */
class TinyNetworkTests: NetworkBaseTest {
    
    func testThatWillNotIssuedByThreadsConcurrency() {
        // Given
        expectation = XCTestExpectation(description: "Requests should not be issued by a threads concurrency")
        
        // When
        MockRequest().request { (response, error) in
            MockRequest().request(handler: self.handler!)
        }
        DispatchQueue.main.async {
            MockRequest().request(handler: self.handler!)
        }
        wait(for: [expectation!], timeout: 10.0)

        // Then
        XCTAssertNotNil(response as? MockResponse)
    }
    
    func testThatShouldNotHandleRedirection() {
        // Given
        expectation = XCTestExpectation(description: "At the time of work, TinyNetwork doesn't support redirections")
        
        // When
        MockRedirectionRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNil(response as? MockResponse)
    }
    
    func testThatShouldHandleBadRequest() {
        // Given
        expectation = XCTestExpectation(description: "should handle bad HTTP response (here status code 400)")
        
        // When
        MockBadRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 10.0)
        
        // Then
        XCTAssertNil(response)
        XCTAssertNotNil(error)
    }

    func testThatShouldHandleTimeOutRequest() {
        // Given
        expectation = XCTestExpectation(description: "should handle timed out requests")
        
        // When
        MockTimedOutRequest().request(handler: handler!)
        wait(for: [expectation!], timeout: 2.0)
        
        // Then
        XCTAssertNil(response)
        XCTAssertNotNil(error)
    }

    // should handle an error when asynchronous method doesn't receive a URLRequest object
    func testThatAsynchronousMethodFailedWithError() {
        // Given
        let request: URLRequest? = nil
        
        // When
        MockRequest().asynchronousRequest(request, handler: handler!)
        
        // Then
        XCTAssertNil(response)
        XCTAssertNotNil(error)
        XCTAssertEqual(error as? Network.NetworkError, Network.NetworkError.invalidRequest)
    }
    
    // should not decode when the data provided doesn't match
    func testThatNotDecodeWhenDataIsUnmatched() {
        // Given
        let jsonString = "{\"foo\": \"bar\"}"
        
        // When
        let decoded = MockRequest().decode(Data(jsonString.utf8))
        
        // Then
        XCTAssertNil(decoded)
    }
}
