//
//  Variable.swift
//  Reflections
//
//  Created by Matt Provost on 7/17/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public protocol Variable {
    associatedtype VariableType
    associatedtype PointerType: ReflectionsPointer where PointerType.Value == VariableType

    var size: Int { get }
    var stride: Int { get }
    var alignment: Int { get }

    var value: VariableType { get }

    init(withVariable variable: PointerType)
}

public class _Variable<T, Pointer: HashablePointer>: Variable where Pointer.Value == T {
    internal var pointer: Pointer

    public private(set) var size: Int
    public private(set) var stride: Int
    public private(set) var alignment: Int

    public var value: T {
        get {
            return pointer.value
        }
    }

    public required init(withVariable variable: Pointer) {
        self.size = MemoryLayout<T>.size
        self.stride = MemoryLayout<T>.stride
        self.alignment = MemoryLayout<T>.alignment

        self.pointer = variable
    }
}
