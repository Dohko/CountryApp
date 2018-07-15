//
//  BaseTest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

class BaseTest: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    func contentFile(named: String, ext: String = "json") -> Data? {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: named, withExtension: ext)
        return NSData(contentsOf: url!) as Data?
    }
}
