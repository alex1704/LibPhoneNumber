//
//  JavaScriptCore+Util.swift
//  
//
//  Created by Alex Kostenko on 16.11.2022.
//

import JavaScriptCore

extension JSContext {
    /// Throws `evaluation` error if exception is not nil
    func throwIfExceptionNonNil() throws {
        guard let exception else {
            return
        }

        throw LibPhoneNumber.Error.evaluation(exception.description)
    }

    func throwableEvaluateScript(_ script: String) throws -> JSValue? {
        guard let result = evaluateScript(script) else {
            try throwIfExceptionNonNil()
            return nil
        }

        return result
    }
}

extension JSValue {
    /// Decode `toString` result into `T`
    /// - Returns: `T` entity on success
    func decode<T: Decodable>() throws -> T? {
        guard let data = toString()?.data(using: .utf8),
              let entity = try? JSONDecoder().decode(T.self, from: data)
        else {
            try context.throwIfExceptionNonNil()
            return nil
        }

        return entity
    }
}
