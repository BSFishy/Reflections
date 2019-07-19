//
//  Variable+Equatable.swift
//  Reflections
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

extension _Variable: Equatable {
    public static func == <LType, LPointer, RType, RPointer>(lhs: _Variable<LType, LPointer>, rhs: _Variable<RType, RPointer>) -> Bool {
        guard let rhsPointer: LPointer = rhs.pointer as? LPointer else { return false }
        return lhs.pointer == rhsPointer
    }
}

public func == <LType: Equatable, LPointer, RType>(lhs: _Variable<LType, LPointer>, rhs: RType) -> Bool {
    guard let rhsValue: LType = rhs as? LType else { return false }
    return lhs.value == rhsValue
}

public func == <LType: Equatable, LPointer, RType>(lhs: RType, rhs: _Variable<LType, LPointer>) -> Bool {
    return rhs == lhs
}

public func == <LType, LPointer, RType: HashablePointer>(lhs: _Variable<LType, LPointer>, rhs: RType) -> Bool {
    guard let rhsPointer: LPointer = rhs as? LPointer else { return false }
    return lhs.pointer == rhsPointer
}

public func == <LType, LPointer, RType: HashablePointer>(lhs: RType, rhs: _Variable<LType, LPointer>) -> Bool {
    return rhs == lhs
}
