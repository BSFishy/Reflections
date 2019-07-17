//
//  Variable.swift
//  Reflections
//
//  Created by Matt Provost on 7/17/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation
import Swift

//fileprivate typealias PointerInfo<T> = (manager: Unmanaged<T>, pointer: UnsafeMutablePointer<T>)

class Variable<T> {
//    internal var manager: Unmanaged<T>!
    internal var pointer: UnsafeMutablePointer<T>!

    private(set) var size: Int
    private(set) var stride: Int
    private(set) var alignment: Int

    var value: T! {
        get {
            return pointer?.pointee
        }
    }

    init() {
        self.size = MemoryLayout<T>.size
        self.stride = MemoryLayout<T>.stride
        self.alignment = MemoryLayout<T>.alignment
    }

    convenience init(asAny variable: UnsafeMutablePointer<T>) {
        self.init()

//        self.manager = Unmanaged<T>.fromOpaque(&variable)
        self.pointer = variable
    }

    deinit {
        self.pointer?.deallocate()
        self.pointer?.deinitialize(count: 1)
    }

//    internal static func toPointer<U>(asAny variable: inout U) -> UnsafeMutablePointer<U> {
//        let pointer: UnsafeMutablePointer<U> = UnsafeMutablePointer<U>.allocate(capacity: 1)
//        pointer.initialize(to: variable)
//        return pointer
//    }
}

extension Variable where T: AnyObject {
    convenience init(withVariable variable: UnsafeMutablePointer<T>) {
        self.init()

        self.pointer = variable
    }

//    convenience init(withVariable variable: T, andType type: T.Type = T.self) {
//        self.init()
//
//        self.pointer = Variable.toPointer(variable, andType: type)
//    }
//
//    internal static func toPointer<U>(_ variable: U, andType type: U.Type = U.self) -> UnsafeMutablePointer<U> where U: AnyObject {
//        let pointer = Unmanaged<U>.passUnretained(variable).toOpaque().bindMemory(to: type, capacity: 1)
//        print(String(format: "var pointer: %p\npointer: %p\nvar: %1$s\npointer var: %2$s", variable as! CVarArg, pointer.pointee as! CVarArg))
//        return pointer
//    }
}
