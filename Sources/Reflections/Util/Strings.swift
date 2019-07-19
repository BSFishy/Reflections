//
//  Strings.swift
//  Reflections
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public protocol CustomStringRepresentation {
    var stringRepresentation: String { get }
}

extension String: CustomStringRepresentation {
    public var stringRepresentation: String {
        return "\"\(self)\""
    }
}

internal func asString<T>(_ variable: T?) -> String {
    guard let variable = variable else { return "nil" }

    if let variable = variable as? CustomStringRepresentation {
        return variable.stringRepresentation
    }

    if let variable = variable as? CustomStringConvertible {
        return variable.description
    }

    if let variable = variable as? CustomDebugStringConvertible {
        return variable.debugDescription
    }

    if let variable = variable as? CustomReflectable {
        return String(reflecting: variable)
    }

    return "\(variable)"
}
