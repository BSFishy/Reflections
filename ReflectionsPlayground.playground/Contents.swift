import Reflections

var variable: String = "primary"
let immutableReference: ImmutableVariable<String> = Reflections.immutable(variable: &variable)
print(String(describing: immutableReference))
print(String(reflecting: immutableReference))
print(immutableReference)

let mutableReference: MutableVariable<String> = Reflections.mutable(variable: &variable)
print(String(describing: mutableReference))
print(String(reflecting: mutableReference))
print(mutableReference)
