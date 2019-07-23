//
//  MutableVariable+Equatable.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

// Variable == variable

public func == <LType, RType, RPointer>(lhs: MutableVariable<LType>, rhs: _Variable<RType, RPointer>) -> Bool {
    guard let rPointer: UnsafeMutablePointer<LType> = rhs.pointer as? UnsafeMutablePointer<LType> else { return false }
    return lhs.pointer == rPointer
}

public func == <LType, RType, RPointer>(lhs: _Variable<RType, RPointer>, rhs: MutableVariable<LType>) -> Bool {
    return rhs == lhs
}

public func == <LType, RType>(lhs: MutableVariable<LType>, rhs: ImmutableVariable<RType>) -> Bool {
    guard let rPointer: UnsafeMutablePointer<LType> = UnsafeMutablePointer(mutating: rhs.pointer) as? UnsafeMutablePointer<LType> else { return false}
    return lhs.pointer == rPointer
}

public func == <LType, RType>(lhs: ImmutableVariable<RType>, rhs: MutableVariable<LType>) -> Bool {
    return rhs == lhs
}

// Variable == pointer

public func == <LType, RType>(lhs: MutableVariable<LType>, rhs: UnsafeMutablePointer<RType>) -> Bool {
    guard let rPointer: UnsafeMutablePointer<LType> = rhs as? UnsafeMutablePointer<LType> else { return false }
    return lhs.pointer == rPointer
}

public func == <LType, RType>(lhs: UnsafeMutablePointer<RType>, rhs: MutableVariable<LType>) -> Bool {
    return rhs == lhs
}

public func == <LType, RType>(lhs: MutableVariable<LType>, rhs: UnsafePointer<RType>) -> Bool {
    guard let rPointer: UnsafeMutablePointer<LType> = UnsafeMutablePointer(mutating: rhs) as? UnsafeMutablePointer<LType> else { return false }
    return lhs.pointer == rPointer
}

public func == <LType, RType>(lhs: UnsafePointer<RType>, rhs: MutableVariable<LType>) -> Bool {
    return rhs == lhs
}

public func == <LType: Equatable, RPointer: ReflectionsPointer, RType>(lhs: MutableVariable<LType>, rhs: RPointer) -> Bool where RPointer.Value == RType {
    guard let rValue: LType = rhs.value as? LType else { return false }
    return lhs.typedValue == rValue
}

public func == <LType: Equatable, RPointer: ReflectionsPointer, RType>(lhs: RPointer, rhs: MutableVariable<LType>) -> Bool where RPointer.Value == RType {
    return rhs == lhs
}

// Variable == value

public func == <LType: Equatable, RType>(lhs: MutableVariable<LType>, rhs: RType) -> Bool {
    guard let rValue: LType = rhs as? LType else { return false }
    return lhs.typedValue == rValue
}

public func == <LType: Equatable, RType>(lhs: RType, rhs: MutableVariable<LType>) -> Bool {
    return rhs == lhs
}
