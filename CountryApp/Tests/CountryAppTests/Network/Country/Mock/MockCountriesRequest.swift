//
//  MockCountriesRequest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

@testable import CountryApp

class MockCountriesRequest: CountriesRequest {
    
    let mockData: Data?
    let mockError: Error?

    init(data: Data?, error: Error?) {
        mockData = data
        mockError = error
    }
    
    override func asynchronousRequest(_ request: URLRequest?,
                                      handler: @escaping ((Countries?, Error?) -> Void)) {
        if let data = mockData { responseReceived(data, nil, nil, handler: handler); return }
        if let error = mockError { responseReceived(nil, nil, error, handler: handler); return }
        super.asynchronousRequest(request, handler: handler)
    }
    
}
