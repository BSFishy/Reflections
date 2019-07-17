//
//  Field.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

class Field<T>: Variable<T> {
    private(set) var name: String

    init(withName name: String) {
        self.name = name

        super.init()
    }

    convenience init(withName name: String, andObject value: UnsafeMutablePointer<T>) {
        self.init(withName: name)

        self.pointer = value
    }
}

extension Field where T: AnyObject {
    convenience init(withName name: String, value: UnsafeMutablePointer<T>) {
        self.init(withName: name)

        self.pointer = value
    }
}
