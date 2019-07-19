//
//  Variable+Hashable.swift
//  Reflections
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

extension _Variable: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.pointer)
    }
}
