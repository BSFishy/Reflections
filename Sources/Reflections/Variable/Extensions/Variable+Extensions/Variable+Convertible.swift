//
//  Variable+CustomPlaygroundDisplayConvertible.swift
//  Reflections
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

extension _Variable: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(self,
                      children: ["value": self.value,
                                 "size": self.size,
                                 "stride": self.stride,
                                 "alignment": self.alignment],
                      displayStyle: .struct,
                      ancestorRepresentation: .customized({ self.customMirror }))
    }
}

extension _Variable: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return "\(type(of: self))(\(asString(self.value)))"
    }
}

extension _Variable: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(type(of: self))(value: \(asString(self.value)), size: \(self.size), stride: \(self.stride), alignment: \(self.alignment))"
    }
}

extension _Variable: CustomStringConvertible {
    public var description: String {
        return "\(type(of: self))(value: \(asString(self.value)))"
    }
}
