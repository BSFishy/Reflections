//
//  String+Extensions.swift
//  Reflections
//
//  Created by Matt Provost on 7/22/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Foundation

extension String {
    internal var nsString: NSString {
        return self as NSString
    }

    internal static func cString(of str: String) -> UnsafePointer<Int8>? {
        return str.nsString.utf8String
//        return str.nsString.utf8String
//        return str.cString(using: Encoding.utf8)
    }
}
