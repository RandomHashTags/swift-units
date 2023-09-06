// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-units",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "SwiftUnits",
            targets: ["SwiftUnits"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/RandomHashTags/swift_huge-numbers.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "SwiftUnits",
            dependencies: [
                .product(name: "HugeNumbers", package: "swift_huge-numbers")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SwiftUnitsTests",
            dependencies: ["SwiftUnits"]
        )
    ]
)
