//
//  ImmutableVariable.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public class ImmutableVariable<T>: _Variable<T, UnsafePointer<T>> {
    public override var value: T {
        get {
            return pointer.pointee
        }
    }
}
