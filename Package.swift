// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ATOCR",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ATOCR",
            targets: ["ATOCR"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/AyanTech/AyanTechNetworkingLibrary-iOS", .upToNextMajor(from: "1.8.0"))
    ],
    targets: [
        .target(
            name: "ATOCR",
            dependencies: [
                .product(name: "AyanTechNetworkingLibrary", package: "AyanTechNetworkingLibrary-iOS"),
            ]
        ),
        .testTarget(
            name: "ATOCRTests",
            dependencies: ["ATOCR"]
        ),
    ]
)
