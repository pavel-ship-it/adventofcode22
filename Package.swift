// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "adventofcode22",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(
            name: "adventofcode22",
            resources: [.copy("Input")]
        )
    ]
)
