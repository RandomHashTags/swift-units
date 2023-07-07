// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-units",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftUnits",
            targets: ["SwiftUnits"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/RandomHashTags/swift_huge-numbers.git", from: "1.0.15")
    ],
    targets: [
        .target(
            name: "SwiftUnits",
            dependencies: [
                .product(name: "HugeNumbers", package: "swift_huge-numbers")
            ]
        ),
        .testTarget(
            name: "SwiftUnitsTests",
            dependencies: ["SwiftUnits"]
        ),
    ]
)
