// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LibPhoneNumber",
    platforms: [
        .iOS(.v13), .macOS(.v11)
    ],
    products: [
        .library(
            name: "LibPhoneNumber",
            targets: ["LibPhoneNumber"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LibPhoneNumber",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "LibPhoneNumberTests",
            dependencies: ["LibPhoneNumber"]
        ),
    ]
)
