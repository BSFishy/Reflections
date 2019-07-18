//
//  Field.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

class Field<T>: Variable<T> {
    private(set) var name: String

    init(withName name: String, andValue value: UnsafeMutablePointer<T>) {
        self.name = name

        super.init(withVariable: value)
    }
}
