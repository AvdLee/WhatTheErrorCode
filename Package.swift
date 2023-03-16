// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhatTheErrorCode",
    platforms: [
        .macOS(.v12),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "WhatTheErrorCode",
            targets: ["WhatTheErrorCode"]),
    ],
    targets: [
        .target(
            name: "WhatTheErrorCode",
            dependencies: [],
            resources: [
                .process("errors.json")
            ]
        ),
        .testTarget(
            name: "WhatTheErrorCodeTests",
            dependencies: ["WhatTheErrorCode"]),
    ]
)
