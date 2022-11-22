//
//  File.swift
//  
//
//  Created by Alex Kostenko on 16.11.2022.
//

import Foundation

extension LibPhoneNumber {
    public enum Error: Swift.Error {
        case evaluation(String)
    }

    public struct PhoneNumber: Decodable {
        // can be initiated without rawInput, ex from getExampleNumber
        public let rawInput: String?
        public let countryCode: Int
        public let nationalNumber: Int

        public var fullNumber: String {
            "\(countryCode)\(nationalNumber)"
        }
    }

    public enum PhoneNumberType: String {
        case fixedLine = "FIXED_LINE"
        case mobile = "MOBILE"
        case fixedLineOrMobile = "FIXED_LINE_OR_MOBILE"
        case tollFree = "TOLL_FREE"
        case premiumRate = "PREMIUM_RATE"
        case sharedCost = "SHARED_COST"
        case voip = "VOIP"
        case personalNumber = "PERSONAL_NUMBER"
        case pager = "PAGER"
        case uan = "UAN"
        case unknown = "UNKNOWN"
    }

    public enum PhoneNumberFormat: String {
        case e164 = "E164"
        case international = "INTERNATIONAL"
        case naitonal = "NATIONAL"
        case rfc3966 = "RFC3966"
    }
}
