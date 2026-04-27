// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ATOCR",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ATOCR",
            targets: ["ATOCR"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "ATOCR"
        ),
        .testTarget(
            name: "ATOCRTests",
            dependencies: ["ATOCR"]
        ),
    ]
)
