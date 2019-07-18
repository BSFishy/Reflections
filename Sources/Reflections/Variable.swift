//
//  Variable.swift
//  Reflections
//
//  Created by Matt Provost on 7/17/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

//import Foundation

class Variable<T> {
    internal var pointer: UnsafeMutablePointer<T>

    private(set) var size: Int
    private(set) var stride: Int
    private(set) var alignment: Int

    var value: T! {
        get {
            return pointer.pointee
        }
        set {
            pointer.pointee = newValue
        }
    }

    init(withVariable variable: UnsafeMutablePointer<T>) {
        self.size = MemoryLayout<T>.size
        self.stride = MemoryLayout<T>.stride
        self.alignment = MemoryLayout<T>.alignment

        self.pointer = variable
    }
}
