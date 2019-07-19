//
//  VariableTests.swift
//  ReflectionsTests
//
//  Created by Matt Provost on 7/18/19.
//  Copyright © 2019 Matt Provost. All rights reserved.
//

import Quick
import Nimble
import SpecLeaks

@testable import Reflections

internal struct VariableTestParameters<T> {
    var name: String
    var primary: T
    var secondary: T
}

class VariableTests: QuickSpec {
    override func spec() {
        bothTests(withName: "boolean", primary: true, andSecondary: false)
        bothTests(withName: "integer", primary: 123, andSecondary: 123456)
        bothTests(withName: "double", primary: 123.456, andSecondary: 123456.789123)
        bothTests(withName: "string", primary: "primary", andSecondary: "secondary")
    }
}

extension VariableTests {
    internal func bothTests<T: Equatable & CVarArg>(withName name: String, primary: T, andSecondary secondary: T) {
        context("immutable") {
            variableTest(withName: name, primary: primary, secondary: secondary, andVariableCreator: { pointer in Reflections.immutable(variable: pointer)})
        }

        context("mutable") {
            variableTest(withName: name, primary: primary, secondary: secondary, andVariableCreator: Reflections.mutable)
        }
    }

    internal func variableTest<T: Equatable & CVarArg, U: _Variable<T, P>, P: CVarArg>(withName name: String, primary: T, secondary: T, andVariableCreator creator: @escaping (UnsafeMutablePointer<T>) -> U) {
        var variable: T = primary
        let reference: U = creator(&variable)

        let variablePointer: UnsafeMutablePointer<T> = UnsafeMutablePointer<T>(mutating: &variable)

        RefDebug.debugLog("Testing \(name) with a primary value of \(stringify(primary)) and secondary value of \(stringify(secondary))\n\tInitial reference: \(String(reflecting: reference))\n\tVariable pointer: %p\n\tReference pointer: %p", variablePointer, reference.pointer)

        describe(name) {
            it("should be equal") {
                RefDebug.debugLog("Comparing equality for \(name) variable of reference (\(stringify(reference.value))) and variable (\(stringify(variable)))")

                expect(reference.value).to(equal(variable), description: "variable and reference are not equal to each other")
            }

            describe("comparing the memory layout and variable") {
                it("should have the same size") {
                    let size: Int = MemoryLayout.size(ofValue: variable)
                    RefDebug.debugLog("Checking size for \(name) variable with reference (\(reference.size)) and actual (\(size))")
                    expect(reference.size).to(equal(size), description: "variable and reference don't have the same size")
                }

                it("should have the same stride") {
                    let stride: Int = MemoryLayout.stride(ofValue: variable)
                    RefDebug.debugLog("Checking stride for \(name) variable with reference (\(reference.stride)) and actual (\(stride))")
                    expect(reference.stride).to(equal(stride), description: "variable and reference don't have the same stride")
                }

                it("should have the same alignment") {
                    let alignment: Int = MemoryLayout.alignment(ofValue: variable)
                    RefDebug.debugLog("Checking alignment for \(name) variable with reference (\(reference.alignment)) and actual (\(alignment))")
                    expect(reference.alignment).to(equal(alignment), description: "variable and reference don't have the same alignment")
                }
            }

            describe("updating") {
                it("should update the reference") {
                    RefDebug.debugLog("Attempting to update the \(name) variable's reference (%p) according to the variable (%p)\n\tFrom: \(stringify(primary))\n\tTo: \(stringify(secondary))", reference.pointer, variablePointer)

                    variable = primary
                    expect(reference.value).to(equal(variable), description: "variable and reference weren't initially equal")
                    variable = secondary
                    expect(reference.value).to(equal(variable), description: "variable and reference didn't become equal")
                }

                it("should update the variable") {
                    if let reference = reference as? MutableVariable<T> {
                        RefDebug.debugLog("Attempting to update the \(name) variable (%p) according to the reference (%p)\n\tFrom: \(stringify(primary))\n\tTo: \(stringify(secondary))", variablePointer, reference.pointer)

                        variable = primary
                        expect(variable).to(equal(reference.value), description: "variable and reference weren't initially equal")
                        reference.value = secondary
                        expect(variable).to(equal(reference.value), description: "variable and reference didn't become equal")
                    } else {
                        RefDebug.debugLog("An immutable reference cannot update the variable. Automatically passing")

                        expect(true).to(beTrue())
                    }
                }
            }

            describe("memory leakage") {
                it("should not leak on initialization") {
                    let ref = LeakTest {
                        creator(&variable)
                    }

                    expect(ref).toNot(leak(), description: "variable reference leaked on initialization")
                }

                it("should not leak on deinitialization") {
                    var tmpRef: U? = creator(&variable)
                    weak var leakRef = tmpRef
                    tmpRef = nil

                    expect(leakRef).to(beNil(), description: "variable reference did not get deinitialized")
                }
            }

            describe("converisons") {
                describe("to description") {
                    it("should not be empty") {
                        let converted: String = reference.description
                        RefDebug.debugLog("Converted \(name) reference to description: \(converted)")

                        expect(converted).toNot(beEmpty())
                    }
                }

                describe("to debug description") {
                    it("should not be empty") {
                        let converted: String = reference.debugDescription
                        RefDebug.debugLog("Converted \(name) reference to debug description: \(converted)")

                        expect(converted).toNot(beEmpty())
                    }
                }

                describe("to playground description") {
                    it("should not be nil or empty") {
                        let converted: String? = reference.playgroundDescription as? String
                        RefDebug.debugLog("Converted \(name) reference to playground description: \(converted ?? "nil")")

                        expect(converted).toNot(beNil())
                        expect(converted).toNot(beEmpty())
                    }
                }

                describe("to string description") {
                    it("should not be empty") {
                        let converted: String = String(describing: reference)
                        RefDebug.debugLog("Converted \(name) reference to string description: \(converted)")

                        expect(converted).toNot(beEmpty())
                    }
                }

                describe("to reflection description") {
                    it("should not be empty") {
                        let converted: String = String(reflecting: reference)
                        RefDebug.debugLog("Converted \(name) reference to reflection description: \(converted)")

                        expect(converted).toNot(beEmpty())
                    }
                }
            }

            describe("equality") {
                describe("equal checks") {
                    it("should equal another equivalent reference") {
                        variable = primary
                        let ref: U = creator(&variable)

                        expect(reference == ref).to(beTrue())
                        expect(ref == reference).to(beTrue())
                    }

                    it("should equal the value pointed to") {
                        variable = primary
                        expect(reference == primary).to(beTrue())
                        expect(primary == reference).to(beTrue())
                    }
                }

                describe("not equal checks") {
                    it("should not equal another equivalent reference") {
                        variable = secondary
                        var vari: T = primary
                        let ref: U = creator(&vari)

                        expect(reference == ref).to(beFalse())
                        expect(ref == reference).to(beFalse())
                    }

                    it("should not equal the value pointed to") {
                        variable = secondary
                        expect(reference == primary).to(beFalse())
                        expect(primary == reference).to(beFalse())
                    }
                }
            }
        }
    }
}
