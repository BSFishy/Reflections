//
//  ReflectionsTests.swift
//  ReflectionsTests
//
//  Created by Matt Provost on 7/16/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Quick
import Nimble

@testable import Reflections

class ReflectionsTests: QuickSpec {
    override func spec() {
        describe("reflected variable") {
            describe("an integer") {
                var variable: Int = 123
                let ref: Variable<Int> = Variable<Int>(asAny: &variable)

                it("should be equal") {
                    expect(ref.value).to(equal(variable))
                }

                it("should be the same size") {
                    expect(ref.size).to(equal(MemoryLayout<Int>.size))
                }

                it("should have the same stride") {
                    expect(ref.stride).to(equal(MemoryLayout<Int>.stride))
                }

                it("should have the same alignment") {
                    expect(ref.alignment).to(equal(MemoryLayout<Int>.alignment))
                }

                it("should be able to change") {
                    expect(ref.value).to(equal(variable))
                    variable += 1
                    expect(ref.value).to(equal(variable))
                }
            }

            describe("a class") {
                var variable: NSObject = NSObject()
                let ref: Variable<NSObject> = Variable<NSObject>(withVariable: &variable)

                it("should be equal") {
                    expect(ref.value).to(equal(variable), description: String(format: "Expected %p to equal %p", variable, ref.value))
                }

                it("should be the same size") {
                    expect(ref.size).to(equal(MemoryLayout<NSObject>.size))
                }

                it("should have the same stride") {
                    expect(ref.stride).to(equal(MemoryLayout<NSObject>.stride))
                }

                it("should have the same alignment") {
                    expect(ref.alignment).to(equal(MemoryLayout<NSObject>.alignment))
                }

                it("should be able to change") {
                    expect(ref.value).to(equal(variable), description: String(format: "Expected %p to equal %p", variable, ref.value))
                    variable = NSObject()
                    expect(ref.value).to(equal(variable), description: String(format: "Expected %p to equal %p", variable, ref.value))
                }
            }
        }
    }
}
