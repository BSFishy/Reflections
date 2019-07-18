//
//  Class.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

class Class<T> {
    private var type: T.Type
    private var mirror: Mirror

    private(set) var name: String
    private(set) var fields: [String: Field<Any>]

    init(describing discriptor: T) {
        self.type = Swift.type(of: discriptor)
        self.mirror = Mirror(reflecting: discriptor)

        self.name = "\(self.type)"
        self.fields = [:]

        let children = self.mirror.children
        for idx in 0..<children.count {
            var child = children[children.index(children.startIndex, offsetBy: idx)]
            self.addChild(label: child.label, value: &child.value)
        }
    }

    private func addChild<T>(label: String?, value: inout T) {
        if let label = label {
            // TODO: see about casting this because I don't think this should be casted
            self.fields[label] = (Field<T>(withName: label, andValue: &value) as! Field<Any>)
        }
    }
}
