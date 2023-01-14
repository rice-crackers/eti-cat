import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SolutionByStepViewModel: ObservableObject {
    @Published var solutionList: [SolutionEntity] = [
        .init(
            level: 1,
            bannerURL: "https://images.unsplash.com/photo-1424847651672-bf20a4b0982b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
            title: "식사 에티켓",
            description: "기본적인 식사예절에 대해서 배워봅시다.",
            imageName: "Spoon",
            content: "",
            isLocked: false
        ),
        .init(
            level: 2,
            bannerURL: "https://images.unsplash.com/photo-1424847651672-bf20a4b0982b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
            title: "회의 에티켓",
            description: "기본적인 회의예절에 대해서 배워봅시다.",
            imageName: "Clipboard",
            content: "",
            isLocked: true
        )
    ]

    init() {
        Firestore.firestore()
    }
}
