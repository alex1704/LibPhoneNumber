# Description

Library for parsing, formatting, and validating international phone numbers.
It leverages functionality of [Google's JS libphonenumber library](https://github.com/google/libphonenumber/tree/master/javascript).
Standalone JS file was generated with [LibphonenumberStandaloneJS](https://github.com/alex1704/LibphonenumberStandaloneJS).

# API

- `public func parsePhoneNumber(_ phoneNumber: String) throws -> PhoneNumber?`
- `public func regionCodeForPhoneNumber(_ phoneNumber: String) throws -> String?`
- `public func examplePhoneNumber(region: String, type: PhoneNumberType = .mobile) throws -> PhoneNumber?`
- `public func isValidPhoneNumber(_ phoneNumber: String, region: String? = nil) throws -> Bool?`
- `public func formatPhoneNumber(_ phoneNumber: String, format: PhoneNumberFormat = .international) throws -> String?`
- `public func formatWithAsYouTypeFormatterPhoneNumber(_ phoneNumber: String) throws -> String?`

# Usage examples

- Validate number
```
guard let libPhoneNumber = LibPhoneNumber() else {
    return
}

do {
    guard let isValid = try libPhoneNumber.isValidPhoneNumber("+380631112233") else {
        return
    }

    print("is valid:", isValid)
} catch {
    print("err: \(error)")
}
```

- Get number example
```
guard let libPhoneNumber = LibPhoneNumber() else {
    return
}

do {
    guard let example = try libPhoneNumber.examplePhoneNumber(region: "UA", type: .mobile) else {
        return
    }

    print("example: \(example)")
} catch {
    print("err: \(error)")
}
```
