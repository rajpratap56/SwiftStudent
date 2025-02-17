// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "organicFarmingApp",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "organicFarmingApp",
            targets: ["AppModule"],
            bundleIdentifier: "com.Raj.organicFarmingApp",
            teamIdentifier: "3N8F6RN984",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bicycle),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .camera(purposeString: "I want to access")
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/richardtop/CalendarKit.git", "1.1.11"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "CalendarKit", package: "calendarkit")
            ],
            path: "."
        )
    ]
)