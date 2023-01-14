import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class EtiquetteViewModel: ObservableObject {
    @Published var etiquetteList: [EtiquetteEntity] = []

    init() {
        Task {
            let snapshot = try await Firestore.firestore().collection("etiquette").getDocuments()
            let etiqueList = snapshot.documents.map {
                let data = $0.data()
                return EtiquetteEntity(name: data["name"] as! String, imageName: data["imageName"] as! String)
            }
            DispatchQueue.main.async {
                self.etiquetteList.append(contentsOf: etiqueList)
            }
        }
    }
}
