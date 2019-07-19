//
//  ImmutableVariable+Equatable.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

// Variable == variable

public func == <LType, RType, RPointer>(lhs: ImmutableVariable<LType>, rhs: _Variable<RType, RPointer>) -> Bool {
    guard let rPointer: UnsafePointer<LType> = rhs.pointer as? UnsafePointer<LType> else { return false }
    return lhs.pointer == rPointer
}

public func == <LType, RType, RPointer>(lhs: _Variable<RType, RPointer>, rhs: ImmutableVariable<LType>) -> Bool {
    return rhs == lhs
}

// Variable == pointer

public func == <LType, RType>(lhs: ImmutableVariable<LType>, rhs: UnsafePointer<RType>) -> Bool {
    guard let rPointer: UnsafePointer<LType> = rhs as? UnsafePointer<LType> else { return false }
    return lhs.pointer == rPointer
}

public func == <LType, RType>(lhs: UnsafePointer<RType>, rhs: ImmutableVariable<LType>) -> Bool {
    return rhs == lhs
}

public func == <LType, RType>(lhs: ImmutableVariable<LType>, rhs: UnsafeMutablePointer<RType>) -> Bool {
    guard let lPointer: UnsafeMutablePointer<RType> = UnsafeMutablePointer(mutating: lhs.pointer) as? UnsafeMutablePointer<RType> else { return false }
    return lPointer == rhs
}

public func == <LType, RType>(lhs: UnsafeMutablePointer<RType>, rhs: ImmutableVariable<LType>) -> Bool {
    return rhs == lhs
}

public func == <LType: Equatable, RPointer: ReflectionsPointer, RType>(lhs: ImmutableVariable<LType>, rhs: RPointer) -> Bool where RPointer.Value == RType {
    guard let rValue: LType = rhs.value as? LType else { return false }
    return lhs.value == rValue
}

public func == <LType: Equatable, RPointer: ReflectionsPointer, RType>(lhs: RPointer, rhs: ImmutableVariable<LType>) -> Bool where RPointer.Value == RType {
    return rhs == lhs
}

// Variable == value

public func == <LType: Equatable, RType>(lhs: ImmutableVariable<LType>, rhs: RType) -> Bool {
    guard let rValue: LType = rhs as? LType else { return false }
    return lhs == rValue
}

public func == <LType: Equatable, RType>(lhs: RType, rhs: ImmutableVariable<LType>) -> Bool {
    return rhs == lhs
}
