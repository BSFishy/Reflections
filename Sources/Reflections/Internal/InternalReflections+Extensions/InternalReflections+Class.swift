//
//  InternalReflections+Class.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

extension InternalReflections {
    internal static func type<T>(of instance: T?) -> T.Type? {
        return instance != nil ? Swift.type(of: instance!) : nil
    }

    internal static func objectClass(of instance: Any?) -> AnyClass? {
        return object_getClass(instance)
    }

    internal static func name(ofClass c: AnyClass?) -> String {
        return String(cString: class_getName(c))
    }

    internal static func name(of instance: AnyObject?) -> String {
        return name(ofClass: type(of: instance))
    }

    internal static func parent(ofClass c: AnyClass?) -> AnyClass? {
        return class_getSuperclass(c)
    }

    internal static func parent(of instance: AnyObject?) -> AnyClass? {
        return parent(ofClass: type(of: instance))
    }

    internal static func version(ofClass c: AnyClass?) -> Int32 {
        return class_getVersion(c)
    }

    internal static func version(of instance: AnyObject?) -> Int32 {
        return version(ofClass: type(of: instance))
    }

    internal static func instanceSize(ofClass c: AnyClass?) -> Int {
        return class_getInstanceSize(c)
    }

    internal static func instanceSize(of instance: AnyObject?) -> Int {
        return instanceSize(ofClass: type(of: instance))
    }

    internal static func instanceVariable(ofClass c: AnyClass?, name: String) -> IVar? {
        return class_getInstanceVariable(c, name)
    }

    internal static func instanceVariable(of instance: AnyObject?, name: String) -> IVar? {
        return instanceVariable(ofClass: objectClass(of: instance), name: name)
    }

    internal static func instanceVariables(ofClass c: AnyClass?) -> [IVar] {
        var result: [IVar] = []
        var count: UInt32 = 0
        guard let ivars: UnsafeMutablePointer<IVar> = class_copyIvarList(c, &count) else { return result }

//        defer {
//            ivars.deallocate()
//        }

        for i in 0..<Int(count) {
            let ivar = ivars[i]
            result.append(ivar)
        }

        return result
    }

    internal static func instanceVariables(of instance: AnyObject?) -> [IVar] {
        return instanceVariables(ofClass: objectClass(of: instance))
    }

    internal static func property(ofClass c: AnyClass?, name: String) -> objc_property_t? {
        return class_getProperty(c, name)
    }

    internal static func property(of instance: AnyObject?, name: String) -> objc_property_t? {
        return property(ofClass: objectClass(of: instance), name: name)
    }

    internal static func properties(ofClass c: AnyClass?) -> [objc_property_t] {
        var result: [objc_property_t] = []
        var count: UInt32 = 0
        guard let props: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(c, &count) else { return result }

//        defer {
//            props.deallocate()
//        }

        for i in 0..<Int(count) {
            let prop = props[i]
            result.append(prop)
        }

        return result
    }

    internal static func properties(of instance: AnyObject?) -> [objc_property_t] {
        return properties(ofClass: objectClass(of: instance))
    }

    internal static func classMethod(ofClass c: AnyClass?, name: String) -> Foundation.Method? {
        return class_getClassMethod(c, sel_getUid(name))
    }

    internal static func classMethod(of instance: AnyObject?, name: String) -> Foundation.Method? {
        return classMethod(ofClass: objectClass(of: instance), name: name)
    }

    internal static func instanceMethod(ofClass c: AnyClass?, name: String) -> Foundation.Method? {
        return class_getInstanceMethod(c, sel_getUid(name))
    }

    internal static func instanceMethod(of instance: AnyObject?, name: String) -> Foundation.Method? {
        return instanceMethod(ofClass: objectClass(of: instance), name: name)
    }

    internal static func methods(ofClass c: AnyClass?) -> [Foundation.Method] {
        var result: [Foundation.Method] = []
        var count: UInt32 = 0
        guard let mthds: UnsafeMutablePointer<Foundation.Method> = class_copyMethodList(c, &count) else { return result }

//        defer {
//            mthds.deallocate()
//        }

        for i in 0..<Int(count) {
            let mthd = mthds[i]
            result.append(mthd)
        }

        return result
    }

    internal static func methods(of instance: AnyObject?) -> [Foundation.Method] {
        return methods(ofClass: objectClass(of: instance))
    }
}
