import JavaScriptCore

/// Library for parsing, formatting, and validating international phone numbers.
/// It leverages functionality of [Google's JS libphonenumber library](https://github.com/google/libphonenumber/tree/master/javascript).
/// Standalone JS file was generated with [LibphonenumberStandaloneJS](https://github.com/alex1704/LibphonenumberStandaloneJS).
/// - Note: Library method returns optional  valuesis because js evaluation returns optional value and it is better to give a chance
/// call site to interpret event instead of, for example, return false when script evaluation returns nil.
public struct LibPhoneNumber {

    /// Instanciate JS context and loads LibphonenumberStandaloneJS functionality
    /// - Parameter jsContent: Content generated with [LibphonenumberStandaloneJS](https://github.com/alex1704/LibphonenumberStandaloneJS).
    /// If it is nil then version shipped with package is used.
    public init?(jsContent: String? = nil) {
        guard let context = JSContext(),
              let content = jsContent ?? loadResource(file: "libphonenumber", resourceType: "js")
        else {
            return nil
        }

        context.evaluateScript(content)
        if let excepion = context.exception {
            print("exception during init: \(excepion.description)")
            return nil
        }
        self.context = context
    }

    /// Attemps to parse `phoneNumber`.
    /// - Parameters:
    ///   - phoneNumber: Phone number string to parse
    /// - Returns: ``LibPhoneNumber.PhoneNumber`` on successful parsing
    public func parsePhoneNumber(_ phoneNumber: String) throws -> PhoneNumber? {
        let script = """
                (function () {
                    let phoneNumber = Libphonenumber.getUtil().parseAndKeepRawInput('\(phoneNumber)');
                    let out = Libphonenumber.extractPropertyObject(phoneNumber);
                    return JSON.stringify(out);
                })()
"""

        return try context.throwableEvaluateScript(script)?.decode()
    }

    /// Extract region code
    /// - Parameter phoneNumber: Phone number string, ex +380634445566
    /// - Returns: Region code, ex 'UA'
    public func regionCodeForPhoneNumber(_ phoneNumber: String) throws -> String? {
        let script = """
                (function () {
                    let number = Libphonenumber.getUtil().parseAndKeepRawInput('\(phoneNumber)');
                    return Libphonenumber.getUtil().getRegionCodeForNumber(number);
                })()
"""

        return try context.throwableEvaluateScript(script)?.toString()
    }

    /// Generates example phone number
    /// - Parameters:
    ///   - region: Region code, ex 'UA'
    ///   - type: Number type
    /// - Returns: Phone example
    public func examplePhoneNumber(
        region: String,
        type: PhoneNumberType? = nil
    ) throws -> PhoneNumber? {
        let script: String
        if let type {
            script = """
                (function () {
                    let numberType = Libphonenumber.getNumberType('\(type.rawValue)');
                    let example = Libphonenumber.getUtil().getExampleNumberForType('\(region)', numberType);
                    let out = Libphonenumber.extractPropertyObject(example);
                    return JSON.stringify(out);
                })()
"""
        } else {
            script = """
                (function () {
                    let example = Libphonenumber.getUtil().getExampleNumber('\(region)');
                    let out = Libphonenumber.extractPropertyObject(example);
                    return JSON.stringify(out);
                })()
"""
        }

        return try context.throwableEvaluateScript(script)?.decode()
    }

    /// Check phone number validity
    /// - Parameters:
    ///   - phoneNumber: Phone number to check
    ///   - region: Region code, ex 'UA'
    /// - Returns: Boolean value indicationg phone validity
    public func isValidPhoneNumber(
        _ phoneNumber: String,
        region: String? = nil
    ) throws -> Bool? {
        let script: String
        if let region {
            script = """
                (function () {
                    let number = Libphonenumber.getUtil().parseAndKeepRawInput('\(phoneNumber)');
                    return Libphonenumber.getUtil().isValidNumberForRegion(number, '\(region)');
                })()
"""
        } else {
            script = """
                (function () {
                    let number = Libphonenumber.getUtil().parseAndKeepRawInput('\(phoneNumber)');
                    return Libphonenumber.getUtil().isValidNumber(number);
                })()
"""
        }

        return try context.throwableEvaluateScript(script)?.toBool()
    }

    /// Formats given phone number
    /// - Parameters:
    ///   - phoneNumber: Phone number to format
    ///   - format: Format type
    /// - Returns: Formatter number, ex '+380 63 111 2233'
    public func formatPhoneNumber(
        _ phoneNumber: String,
        format: PhoneNumberFormat = .international
    ) throws -> String? {
        let script = """
                (function () {
                    let number = Libphonenumber.getUtil().parseAndKeepRawInput('\(phoneNumber)');
                    let format = Libphonenumber.getPhoneNumberFormat('\(format.rawValue)');
                    return Libphonenumber.getUtil().format(number, format);
                })()
"""

        guard let value = try context.throwableEvaluateScript(script)?.toString(),
              value != "undefined" // for some reason error is not thrown in JS, handle this case here
        else {
            return nil
        }

        return value
    }

    // MARK: - Private

    private let context: JSContext
}
