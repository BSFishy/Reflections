// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Reflections",
    products: [
        .library(name: "Reflections", targets: ["Reflections"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.2"),
    ],
    targets: [
        .target(name: "Reflections"),
        .testTarget(name: "ReflectionsTests", dependencies: ["Reflections", "Quick", "Nimble"]),
    ],
    swiftLanguageVersions: [.v5]
)
