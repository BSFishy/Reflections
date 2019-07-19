//
//  Pointer+Extensions.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

public typealias HashablePointer = ReflectionsPointer & Hashable

public protocol ReflectionsPointer {
    associatedtype Value

    var value: Value { get }
}

extension UnsafePointer: ReflectionsPointer {
    public var value: Pointee {
        get {
            return self.pointee
        }
    }
}

extension UnsafeMutablePointer: ReflectionsPointer {
    public var value: Pointee {
        get {
            return self.pointee
        }
        set {
            self.pointee = newValue
        }
    }
}
