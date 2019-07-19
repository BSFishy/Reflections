//
//  Reflections.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

public class Reflections {
    private init() {}

    public static func immutable<T>(variable: UnsafePointer<T>) -> ImmutableVariable<T> {
        return ImmutableVariable<T>(withVariable: variable)
    }

    public static func mutable<T>(variable: UnsafeMutablePointer<T>) -> MutableVariable<T> {
        return MutableVariable<T>(withVariable: variable)
    }
}

class RefDebug {
    static func debugLog(_ message: String?, _ args: CVarArg...) {
        #if DEBUG
        print(String(format: message ?? "", arguments: args))
        #endif
    }

    // Copied from Quick/ErrorUtility.swift
    static func raiseError(_ message: String) -> Never {
        #if canImport(Darwin)
        NSException(name: .internalInconsistencyException, reason: message, userInfo: nil).raise()
        #endif

        // This won't be reached when ObjC is available and the exception above is raised
        fatalError(message)
    }
}
