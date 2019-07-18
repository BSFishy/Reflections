//
//  Reflections.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

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
