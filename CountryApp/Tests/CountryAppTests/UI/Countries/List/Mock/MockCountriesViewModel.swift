//
//  MockCountriesViewModel.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation
@testable import CountryApp

/*
 Notice:
    Here it's not a really good practice.
    We rewrite the "request" method to call the "MockCountriesRequest" instead
    of "CountriesRequest"
 */
class MokeCountriesViewModel: CountriesViewModel {
    
    let mockData: Data?
    let mockError: Error?
    
    init(data: Data?, error: Error?) {
        mockData = data
        mockError = error
    }

    override func request() {
        isLoading = true
        MockCountriesRequest(data: mockData, error: mockError).request { (countries, error) in
            self.isLoading = false
            if let error = error {
                self.requestFailed?(error)
            }
            else if let countries = countries {
                self.countriesReceived(countries)
            }
        }
    }

}
