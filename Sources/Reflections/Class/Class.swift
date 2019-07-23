//
//  Class.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

public class Class<T: AnyObject> {
    internal var type: T.Type
    internal var mirror: Mirror

    public private(set) var name: String

    public internal(set) var fields: [String: Field]
    public internal(set) var anonymousFields: [Field]

    public internal(set) var properties: [String: Property]

    public init(describing descriptor: T) {
        self.type = Reflections.type(of: descriptor)!
        self.mirror = Mirror(reflecting: descriptor)

        self.name = Reflections.name(ofClass: self.type)

        self.fields = [:]
        self.anonymousFields = []

        self.properties = [:]

        self.prepareFields()
    }
}
