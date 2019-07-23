//
//  Field.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public protocol Field {
    var name: String { get }
    var value: Any { get }
}

public protocol TypedField: TypedVariable, Field {
    init(withName name: String, andValue value: UnsafeMutablePointer<Value>)
}

public class _Field<T>: TypedField {
    internal var pointer: UnsafeMutablePointer<Value>

    public private(set) var name: String

    public private(set) var size: Int
    public private(set) var stride: Int
    public private(set) var alignment: Int

    public var typedValue: T {
        get {
            return pointer.value
        }
    }

    public var value: Any {
        get {
            return typedValue
        }
    }

    public required init(withName name: String, andValue value: UnsafeMutablePointer<T>) {
        self.name = name

        self.size = MemoryLayout<T>.size
        self.stride = MemoryLayout<T>.stride
        self.alignment = MemoryLayout<T>.alignment

        self.pointer = value
    }

    public required convenience init(withVariable variable: UnsafeMutablePointer<T>) {
        self.init(withName: "anonymous", andValue: variable)
    }
}
