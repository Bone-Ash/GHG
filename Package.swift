// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GHG",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "GHG",
            targets: ["GHG"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elai950/AlertToast", .upToNextMajor(from: "1.3.9")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", .upToNextMajor(from: "1.8.2")),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", .upToNextMajor(from: "24.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.12.0")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.3")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.2"))
    ],
    targets: [
        .target(
            name: "GHG",
            dependencies: [
                "AlertToast",
                "CryptoSwift",
                .product(name: "KeychainSwift", package: "keychain-swift"),
                "Kingfisher",
                "Moya",
                "SwiftyJSON"
            ],
            path: "Sources/GHG",
            sources: [
                "Core",
                "Extension",
                "Views"
            ]
        ),
        .testTarget(
            name: "GHGTests",
            dependencies: ["GHG"],
            path: "Tests/GHGTests"
        ),
    ]
)
