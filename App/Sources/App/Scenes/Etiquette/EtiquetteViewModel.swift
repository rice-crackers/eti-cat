import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class EtiquetteViewModel: ObservableObject {
    @Published var etiquetteList: [EtiquetteEntity] = [
        .init(name: "메일", imageName: "E-mail"),
        .init(name: "회의", imageName: "Clipboard"),
        .init(name: "명함", imageName: "IdentificationCard"),
        .init(name: "인사", imageName: "WavingHand"),
        .init(name: "운전", imageName: "Automobile"),
        .init(name: "전화", imageName: "Telephone"),
        .init(name: "회식", imageName: "Beer"),
        .init(name: "식자", imageName: "Spoon")
    ]

    init() {
        Firestore.firestore()
    }
}
