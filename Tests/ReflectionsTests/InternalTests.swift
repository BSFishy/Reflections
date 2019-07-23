//
//  InternalTests.swift
//  ReflectionsTests
//
//  Created by Matt Provost on 7/22/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Quick
import Nimble
import Foundation

@testable import Reflections

class Cls: Reflectable {
    var ivar: String
    var ivar2: Int
    static let staticProp: String = "test"
    public var prop: String {
        get {
            return ivar
        }
    }

    init(ivar: String, ivar2: Int) {
        self.ivar = ivar
        self.ivar2 = ivar2
    }

    func test() {
        print(self.ivar)
    }
}

class InternalTests: QuickSpec {
    override func spec() {
        describe("internals") {
            describe("class") {
                var cls: Cls! = nil
                let ivarValue: String = "test"

                beforeSuite {
                    cls = Cls(ivar: ivarValue, ivar2: 123)
                    print("befored")
                }

                describe("instance variables") {
                    describe("get all") {
                        it("should return something") {
                            expect(InternalReflections.instanceVariables(of: cls)).toNot(beEmpty())
                        }
                    }

                    describe("get a specific") {
                        it("should get a string") {
                            let ivar = InternalReflections.instanceVariable(of: cls, name: "ivar")!
                            object_getIvar(Unmanaged.passRetained(cls).takeUnretainedValue(), ivar)
                            let ivarValue: String? = InternalReflections.get(ivar: ivar, from: cls)
                            //                            let ivar: String? = InternalReflections.get(ivarName: "ivar", from: cls)

                            expect(ivarValue).toNot(beNil())
                            expect(ivarValue).to(equal(ivarValue))
                        }
                    }
                }
            }
        }
    }
}
