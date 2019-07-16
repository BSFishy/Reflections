// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Reflections",
    products: [
        .library(name: "Reflections", targets: ["Reflections"])
    ],
    targets: [
        .target(name: "Reflections"),
        .testTarget(name: "ReflectionsTests", dependencies: ["Reflections"]),
    ],
    swiftLanguageVersions: [.v5]
)
