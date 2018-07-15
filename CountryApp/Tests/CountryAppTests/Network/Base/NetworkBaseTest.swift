//
//  NetworkBaseTest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest

class NetworkBaseTest: BaseTest {
    
    var handler: ((Any?, Error?) -> (Void))?
    var response: Any?
    var error: Error?
    
    override func setUp() {
        super.setUp()
        handler = { (response, error) in
            self.response = response
            self.error = error
            self.expectation?.fulfill()
        }
    }
    
}
