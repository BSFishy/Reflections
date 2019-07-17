//
//  Reflections.swift
//  Reflections
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

func debugLog(_ message: String?, _ args: Any?...) {
    #if DEBUG
    print(String(format: message ?? "", args))
    #endif
}
