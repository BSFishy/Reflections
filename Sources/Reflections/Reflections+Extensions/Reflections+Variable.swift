//
//  Reflections+Variable.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

extension Reflections {
    public static func immutable<T>(variable: UnsafePointer<T>) -> ImmutableVariable<T> {
        return ImmutableVariable<T>(withVariable: variable)
    }

    public static func mutable<T>(variable: UnsafeMutablePointer<T>) -> MutableVariable<T> {
        return MutableVariable<T>(withVariable: variable)
    }
}
