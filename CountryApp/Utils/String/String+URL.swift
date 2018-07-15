//
//  String+URL.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

extension String {
    var isURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        guard let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)),
            let url = URL(string: self),
            let scheme = url.scheme, ["http", "https"].contains(scheme.lowercased()),
            match.range.length == self.endIndex.encodedOffset
            else { return false }
        return true
    }
}
