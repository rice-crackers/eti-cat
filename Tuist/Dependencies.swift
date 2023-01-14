import ProjectDescription

let dependency = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/badrinathvm/StepperView.git", requirement: .exact("1.6.7")),
        .remote(url: "https://github.com/kean/Nuke.git", requirement: .upToNextMajor(from: "11.5.3"))
    ],
    platforms: [.iOS]
)
