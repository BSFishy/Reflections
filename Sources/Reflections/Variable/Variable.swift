//
//  Variable.swift
//  Reflections
//
//  Created by Matt Provost on 7/17/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public protocol Variable {
    var size: Int { get }
    var stride: Int { get }
    var alignment: Int { get }

    var value: Any { get }
}

public protocol TypedVariable {
    associatedtype Value
    associatedtype Pointer: ReflectionsPointer where Pointer.Value == Value

    var size: Int { get }
    var stride: Int { get }
    var alignment: Int { get }

    var typedValue: Value { get }

    init(withVariable variable: Pointer)
}

public class _Variable<T, P: HashablePointer>: TypedVariable where P.Value == T {
    internal var pointer: P

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
            return self.typedValue
        }
    }

    public required init(withVariable variable: P) {
        self.size = MemoryLayout<T>.size
        self.stride = MemoryLayout<T>.stride
        self.alignment = MemoryLayout<T>.alignment

        self.pointer = variable
    }
}
