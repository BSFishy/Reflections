//
//  Class+Child.swift
//  Reflections
//
//  Created by Matt Provost on 7/19/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

extension Class {
    internal func prepareFields() {
        let children = self.mirror.children
        for idx in 0..<children.count {
            var child = children[children.index(children.startIndex, offsetBy: idx)]
            addField(withLabel: child.label, andValue: &child.value)
        }
    }

    private func addField<T>(withLabel label: String?, andValue value: UnsafeMutablePointer<T>) {
        if let label = label {
            self.fields[label] = _Field<T>(withName: label, andValue: value)
        } else {
            self.anonymousFields.append(_Field<T>(withVariable: value))
        }
    }
}
