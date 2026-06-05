// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Spine",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Spine", targets: ["Spine"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Thomvis/BrightFutures.git", from: "8.2.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "Spine",
            dependencies: ["BrightFutures", "SwiftyJSON"],
            path: "Spine"
        ),
    ],
    swiftLanguageModes: [.v5]
)
