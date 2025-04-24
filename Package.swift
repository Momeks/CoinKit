// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoinKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CoinKit",
            targets: ["CoinKit"]),
    ],
    targets: [
        .target(
            name: "CoinKit"),
        .testTarget(
            name: "CoinKitTests",
            dependencies: ["CoinKit"]
        ),
    ]
)
