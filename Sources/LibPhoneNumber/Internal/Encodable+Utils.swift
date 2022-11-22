//
//  File.swift
//  
//
//  Created by Alex Kostenko on 16.11.2022.
//

import Foundation

extension Encodable {
    /// Encode itself with `JSONEncoder` without escaping slashes and converts result into String
    public var jsRequestEncodedString: String? {
        get throws {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .withoutEscapingSlashes
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        }
    }
}
