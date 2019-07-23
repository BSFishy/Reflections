//
//  Reflections+Class.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

extension Reflections {
    public static func type<T>(of instance: T?) -> T.Type? {
        return instance != nil ? Swift.type(of: instance!) : nil
    }

    public static func name(ofClass c: AnyClass?) -> String {
        return c != nil ? "\(c!)" : "nil"
    }

    public static func name(of instance: AnyObject?) -> String {
        return name(ofClass: type(of: instance))
    }
}
