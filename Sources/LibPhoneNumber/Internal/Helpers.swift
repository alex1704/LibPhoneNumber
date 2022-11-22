//
//  File.swift
//  
//
//  Created by Alex Kostenko on 15.11.2022.
//

import Foundation

/// Load resource as a string  from ``Bundle.module``
/// - Parameters:
///   - named: File name
///   - resourceType: File extension
/// - Returns: File contents if resource was found
func loadResource(file named: String,
                  resourceType: String) -> String? {
    guard let fileUrl = Bundle.module.url(forResource: named, withExtension: resourceType),
          let content = try? String(contentsOf: fileUrl, encoding: .utf8)
    else {
        return nil
    }

    return content
}
