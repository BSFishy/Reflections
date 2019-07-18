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

// MARK: Variable constants

fileprivate let sharedVariableTest: String = "variable"

fileprivate let testName: String           = "name"
fileprivate let testPrimaryValue: String   = "primaryValue"
fileprivate let testSecondaryValue: String = "secondaryValue"

fileprivate let defaultTestName: String    = "unspecified"

// MARK: Helper methods

fileprivate func createContext<T: Hashable>(withName name: String, primary: T, andSecondary secondary: T) -> [String: Any] {
    var context: [String: Any] = [:]

    context[testName] = name
    context[testPrimaryValue] = primary
    context[testSecondaryValue] = secondary

    return context
}

// MARK: Tests

class SharedVariableConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        sharedExamples(sharedVariableTest) { (sharedExampleContext: @escaping SharedExampleContext) in
            let context: [String: Any] = sharedExampleContext()

            let name: String = (context[testName] as? String) ?? defaultTestName

            guard let primaryValue: AnyHashable = context[testPrimaryValue] as? AnyHashable
                , let secondaryValue: AnyHashable = context[testSecondaryValue] as? AnyHashable else {
                    RefDebug.raiseError("No initial/secondary value pair was specified for \(name) variable tests")
            }

            var variable: AnyHashable = primaryValue
            let reference: Variable<AnyHashable> = Variable<AnyHashable>(withVariable: &variable)

            RefDebug.debugLog("Testing \(name) with a primary value of \(primaryValue) and secondary value of \(secondaryValue)\n\tVariable pointer: %p\n\tReference pointer: %p", variable as CVarArg, reference.value! as CVarArg)

            describe(name) {
                it("should be equal") {
                    RefDebug.debugLog("Comparing equality for \(name) variable of reference (\(reference.value!)) and variable (\(variable))")
                    expect(reference.value).to(equal(variable), description: "variable and reference are not equal to each other")
                }

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

                it("should update the reference") {
                    RefDebug.debugLog("Attempting to update the \(name) variable's reference (%p) according to the variable (%p)\n\tFrom: \(primaryValue)\n\tTo: \(secondaryValue)", reference.value! as CVarArg, variable as CVarArg)
                    variable = primaryValue
                    expect(reference.value).to(equal(variable), description: "variable and reference weren't initially equal")
                    variable = secondaryValue
                    expect(reference.value).to(equal(variable), description: "variable and reference didn't become equal")
                }

                it("should update the variable") {
                    RefDebug.debugLog("Attempting to update the \(name) variable (%p) according to the reference (%p)\n\tFrom: \(primaryValue)\n\tTo: \(secondaryValue)", variable as CVarArg, reference.value! as CVarArg)
                    variable = primaryValue
                    expect(variable).to(equal(reference.value), description: "variable and reference weren't initially equal")
                    reference.value = secondaryValue
                    expect(variable).to(equal(reference.value), description: "variable and reference didn't become equal")
                }

                describe("memory leakage") {
                    it("should not leak on initialization") {
                        let ref = LeakTest {
                            Variable<AnyHashable>(withVariable: &variable)
                        }

                        expect(ref).toNot(leak(), description: "variable reference leaked on initialization")
                    }

                    it("should not leak on deinitialization") {
                        var tmpRef: Variable<AnyHashable>? = Variable<AnyHashable>(withVariable: &variable)
                        weak var leakRef = tmpRef
                        tmpRef = nil

                        expect(leakRef).to(beNil(), description: "variable reference did not get deinitialized")
                    }
                }
            }
        }
    }
}

class VariableTests: QuickSpec {
    override func spec() {
        itBehavesLike(sharedVariableTest) { createContext(withName: "integer", primary: 123, andSecondary: 123456) }
        itBehavesLike(sharedVariableTest) { createContext(withName: "string", primary: "primary", andSecondary: "secondary") }
    }
}
