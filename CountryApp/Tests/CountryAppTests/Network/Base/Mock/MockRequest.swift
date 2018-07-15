//
//  MockRequest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation
@testable import CountryApp

struct MockResponse: Codable {
    let hello: String
}

class MockRequest: TinyNetwork<MockResponse> {
    
    override var urlString: String? { get { return "https://www.mocky.io/v2/5185415ba171ea3a00704eed" } }
    
}

class MockRedirectionRequest: TinyNetwork<MockResponse> {
    
    override var urlString: String? { get { return "http://www.mocky.io/v2/5b4af8392f000079001e0e78" } }
    
}

class MockBadRequest: TinyNetwork<MockResponse> {
    override var urlString: String? { get { return "http://www.mocky.io/v2/5b4aff762f00009b021e0e7e" } }
}

class MockTimedOutRequest: TinyNetwork<MockResponse> {
    
    override var timeOut: UInt { return 1 }
    
    override var urlString: String? { get { return "https://www.mocky.io/v2/5185415ba171ea3a00704eed?mocky-delay=2000ms" } }
    
}
