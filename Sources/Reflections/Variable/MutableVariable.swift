//
//  MutableVariable.swift
//  Reflections
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public class MutableVariable<T>: _Variable<T, UnsafeMutablePointer<T>> {
    public override var value: T {
        get {
            return pointer.pointee
        }
        set {
            pointer.pointee = newValue
        }
    }
}
