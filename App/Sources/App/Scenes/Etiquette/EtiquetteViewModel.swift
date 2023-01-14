import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class EtiquetteViewModel: ObservableObject {
    @Published var etiquetteList: [EtiquetteEntity] = []
    @Published var isLoaded = false
    @Published var selectedSolution: SolutionEntity?
    @Published var isDetailShow = false

    init() {
        etiquetteList = (0..<8).map { _ in EtiquetteEntity(name: "더미", imageName: "", content: "", relation: nil) }
        fetchEtiquette()
    }

    func etiquetteDidTap(etiquette: EtiquetteEntity) {
        guard let reference = etiquette.relation else { return }
        Task {
            let snapshot = try await Firestore.firestore().collection("solution").document(reference).getDocument()
            let data = snapshot.data() ?? [:]
            let solution = SolutionEntity(
                level: data["level"] as! Int,
                bannerURL: data["bannerURL"] as! String,
                title: data["title"] as! String,
                description: data["description"] as! String,
                imageName: data["imageName"] as! String,
                content: data["content"] as! String
            )
            selectedSolution = solution
            isDetailShow = true
        }
    }

    func fetchEtiquette() {
        Task {
            let snapshot = try await Firestore.firestore().collection("etiquette").getDocuments()
            let etiqueList = snapshot.documents.map {
                let data = $0.data()
                return EtiquetteEntity(
                    name: data["name"] as! String,
                    imageName: data["imageName"] as! String,
                    content: data["content"] as! String,
                    relation: data["relation"] as? String
                )
            }
            DispatchQueue.main.async {
                self.etiquetteList = etiqueList
                
                withAnimation { self.isLoaded = true }
            }
        }
    }
}
