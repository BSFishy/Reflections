//
//  InternalReflections+IVar.swift
//  Reflections
//
//  Created by Matt Provost on 7/22/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

extension InternalReflections {
    internal static func name(ofIvar ivar: IVar) -> String? {
        let n = ivar_getName(ivar)
        return n != nil ? String(cString: n!) : nil
    }

    internal static func name(ofIvar ivar: String, inClass cls: AnyClass?) -> String? {
        let v = instanceVariable(ofClass: cls, name: ivar)
        return v != nil ? name(ofIvar: v!) : nil
    }

    internal static func name(ofIvar ivar: String, in instance: AnyObject?) -> String? {
        return name(ofIvar: ivar, inClass: objectClass(of: instance))
    }

    internal static func encoding(ofIvar ivar: IVar) -> String? {
        let enc = ivar_getTypeEncoding(ivar)
        return enc != nil ? String(cString: enc!) : nil
    }

    internal static func encoding(ofIvar ivar: String, inClass cls: AnyClass?) -> String? {
        let v = instanceVariable(ofClass: cls, name: ivar)
        return v != nil ? encoding(ofIvar: v!) : nil
    }

    internal static func encoding(ofIvar ivar: String, in instance: AnyObject?) -> String? {
        return encoding(ofIvar: ivar, inClass: objectClass(of: instance))
    }

    internal static func offset(ofIvar ivar: IVar) -> Int {
        return ivar_getOffset(ivar)
    }

    internal static func offset(ofIvar ivar: String, inClass cls: AnyClass?) -> Int {
        guard let v = instanceVariable(ofClass: cls, name: ivar) else { return -1 }
        return offset(ofIvar: v)
    }

    internal static func offset(ofIvar ivar: String, in instance: AnyObject?) -> Int {
        return offset(ofIvar: ivar, inClass: objectClass(of: instance))
    }

    internal static func get<T>(ivar: IVar, from instance: AnyObject?, type: T.Type = T.self) -> T? {
        guard let instance = instance else { return nil }

        let instancePointer = Unmanaged.passUnretained(instance).toOpaque()

        return instancePointer.advanced(by: offset(ofIvar: ivar)).load(as: type)
    }

    internal static func get<T>(ivarName ivar: String, from instance: AnyObject?, type: T.Type = T.self) -> T? {
        let i = instanceVariable(of: instance, name: ivar)
        return i != nil ? get(ivar: i!, from: instance, type: type) : nil
    }
}
