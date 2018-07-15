//
//  Network.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

class Network {
    
    enum NetworkError: Error {
        case invalidUrl
        case invalidRequest
        case decoding
    }
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
}
