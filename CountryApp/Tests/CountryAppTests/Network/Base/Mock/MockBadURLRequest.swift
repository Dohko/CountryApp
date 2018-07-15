//
//  MockBadURLRequest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

@testable import CountryApp

struct MockBadURLResponse: Codable {}

class MockBadURLRequest: TinyNetwork<MockBadURLResponse> {
    
    override var urlString: String? { get { return "5185415ba171ea3a00704eed" } }
    
}

class MockURLEmptyRequest: TinyNetwork<MockBadURLResponse> {
    
    override var urlString: String? { get { return "" } }
    
}

class MockURLWhiteSpacedRequest: TinyNetwork<MockBadURLResponse> {
    
    override var urlString: String? { get { return "    " } }
    
}

class MockFileSystemURLRequest: TinyNetwork<MockBadURLResponse> {
    
    override var urlString: String? { get { return "file:///toto" } }
    
}

class MockNotAllowedURLSchemeRequest: TinyNetwork<MockBadURLResponse> {
    
    override var urlString: String? { get { return "ftp://toto" } }
    
}

