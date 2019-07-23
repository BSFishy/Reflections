@testable import Reflections
import Foundation
import ObjectiveC.runtime

class Parent: Reflectable {

}

class Child: Parent {
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

let ch = Child(ivar: "test", ivar2: 123)
//let nameVar: IVar? = InternalReflections.instanceVariable(of: ch, name: "ivar")
//let nameVar2: IVar? = InternalReflections.instanceVariable(of: ch, name: "ivar2")
//let nameProp: objc_property_t? = InternalReflections.property(of: ch, name: "prop")
//
//let props = InternalReflections.properties(of: ch)
//for prop in props {
//    print("Property - \(String(cString: property_getName(prop)))")
//}

let ivar = class_getInstanceVariable(object_getClass(ch), "ivar")!
//print(InternalReflections.name(ofIvar: ivar)!, ivar_getOffset(ivar))
let unmanaged = Unmanaged.passUnretained(ch)
let pointer = unmanaged.toOpaque()
let p = pointer.advanced(by: ivar_getOffset(ivar))
print(p, p.load(as: String.self))
//let ivarValue: String? = InternalReflections.get(ivarName: "ivar", from: ch)
//let ivar2Value: Int? = InternalReflections.get(ivarName: "ivar2", from: ch)
//print(ivarValue ?? "nil", ivar2Value ?? -1)

var ivars = InternalReflections.instanceVariables(of: ch)
for ivar in ivars {
    let name = InternalReflections.name(ofIvar: ivar)
    object_getIvar(ch, ivar)
    print("Ivar - \(name ?? "nil"), value=\(InternalReflections.get(ivar: ivar, from: ch) ?? "nil")")
}

var methods = InternalReflections.methods(of: ch)
for method in methods {
    print("Method - \(String(cString: sel_getName(method_getName(method))))")
}
