// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 * Copyright IBM Corporation 2016, 2017, 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import PackageDescription
 
#if os(Linux)
var targets: [PackageDescription.Target] = [
    .systemLibrary(
        name: "CZlib",
        pkgConfig: "libz",
        providers: [
            .apt(["libz-dev"])
        ]
    ),
    .target(
        name: "KituraWebSocket",
        dependencies: ["CZlib", "KituraNet"]),
    .target(
        name: "TestWebSocketService",
        dependencies: ["KituraNet", "KituraWebSocket"]),
    .testTarget(
        name: "KituraWebSocketTests",
        dependencies: ["KituraWebSocket", "Cryptor"])
]
#else
var targets: [PackageDescription.Target] = [
    .target(
        name: "KituraWebSocket",
        dependencies: ["KituraNet"]),
    .target(
        name: "TestWebSocketService",
        dependencies: ["KituraNet", "KituraWebSocket"]),
    .testTarget(
        name: "KituraWebSocketTests",
        dependencies: ["KituraWebSocket", "Cryptor"])
]
#endif

let package = Package(
    name: "KituraWebSocket",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Kitura-WebSocket",
            targets: ["KituraWebSocket"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/IBM-Swift/Kitura-NIO.git", from: "2.2.0"),
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "1.0.0"),
    ],
    targets: targets
)
