//
//  TinyNetwork.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

class TinyNetwork<Response: Codable>: Network {
    
    var urlString: String? { get { return nil } }
    var method: Network.HTTPMethod { get { return .get } }
    var timeOut: UInt { return 10 }
    var cachePolicy: NSURLRequest.CachePolicy { return .reloadIgnoringLocalAndRemoteCacheData }
    
    func request(handler: @escaping ((Response?, Error?) -> Void)) {
        guard let urlString = urlString,
            let url = URL(string: urlString),
            urlString.isURL else { handler(nil, NetworkError.invalidUrl); return }

        let request = NSMutableURLRequest(url: url)
        request.cachePolicy = cachePolicy
        request.timeoutInterval = TimeInterval(timeOut)
        request.httpMethod = method.rawValue

        asynchronousRequest(request as URLRequest, handler: handler)
    }
    
    // MARK: overwritten
    /* overwrite them to simulate a mock request - helpful for unit tests */
    
    internal func asynchronousRequest(_ request: URLRequest?, handler: @escaping ((Response?, Error?) -> Void)) {
        guard let request = request else { handler(nil, NetworkError.invalidRequest); return }
        URLSession.shared.dataTask(with: request) {data, response, error in
            self.responseReceived(data, response, error, handler: handler)
        }.resume()
    }
    
    internal func responseReceived(_ data: Data?, _ response: URLResponse?, _ error: Error?, handler: @escaping ((Response?, Error?) -> Void)) {
        guard let data = data, error == nil else { handler(nil, error); return }
        guard let decoded = self.decode(data) else { handler(nil, NetworkError.decoding); return }
        DispatchQueue.main.async {
            handler(decoded, nil)
        }
    }
    
    internal func decode(_ data: Data) -> Response? {
        guard let decoded = try? JSONDecoder().decode(Response.self, from: data) else { return nil}
        return decoded
    }
}
