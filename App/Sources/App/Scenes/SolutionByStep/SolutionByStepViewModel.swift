import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SolutionByStepViewModel: ObservableObject {
    @Published var solutionList: [SolutionEntity] = []
    @Published var isLoaded = false
    
    init() {
        solutionList = (0..<4).map { _ in
            SolutionEntity(
                level: 0,
                bannerURL: "",
                title: "더미더미 더미",
                description: "더미더미더미더미더미더미더미",
                imageName: "",
                content: "",
                isLocked: false
            )
        }
        
        fetchSolution()
    }
    
    private func fetchSolution() {
        Task {
            let snapshot = try await Firestore.firestore().collection("solution").order(by: "level").getDocuments()
            let solutionList = snapshot.documents.map {
                let data = $0.data()
                return SolutionEntity(
                    level: data["level"] as! Int,
                    bannerURL: data["bannerURL"] as! String,
                    title: data["title"] as! String,
                    description: data["description"] as! String,
                    imageName: data["imageName"] as! String,
                    content: data["content"] as! String,
                    isLocked: data["isLocked"] as! Bool
                )
            }
            DispatchQueue.main.async {
                self.solutionList = solutionList
                withAnimation { self.isLoaded = true }
            }
        }
    }
}
