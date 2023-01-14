import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Eticat",
    product: .app,
    packages: [
        .Firebase,
        .MarkdownUI
    ],
    dependencies: [
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore,
        .SPM.FirebaseFirestoreSwift,
        .SPM.FirebaseStorage,
        .SPM.NukeUI,
        .SPM.StepperView,
        .SPM.MarkdownUI
    ],
    resources: ["Resources/**"],
    entitlements: Path("Support/Rice.entitlements"),
    infoPlist: .file(path: "Support/Info.plist")
)
