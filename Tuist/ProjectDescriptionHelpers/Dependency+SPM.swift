import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let FirebaseAuth = TargetDependency.package(product: "FirebaseAuth")
    static let FirebaseFirestore = TargetDependency.package(product: "FirebaseFirestore")
    static let FirebaseFirestoreSwift = TargetDependency.package(product: "FirebaseFirestoreSwift")
    static let FirebaseStorage = TargetDependency.package(product: "FirebaseStorage")
    static let StepperView = TargetDependency.external(name: "StepperView")
    static let NukeUI = TargetDependency.external(name: "NukeUI")
    static let MarkdownUI = TargetDependency.package(product: "MarkdownUI")
}

public extension Package {
    static let Firebase = Package.remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "9.4.0")
    )
    
    static let MarkdownUI = Package.remote(
        url: "https://github.com/gonzalezreal/MarkdownUI.git",
        requirement: .upToNextMajor(from: "1.1.1")
    )
}
