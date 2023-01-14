import Combine
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class LoginViewModel: ObservableObject {
    @Published var isSuccessSignin = false
    var nonce = ""

    func appleSigninCompleted(idData: Data) {
        guard let idToken = String(data: idData, encoding: .utf8) else { return }
        let cred = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idToken,
            rawNonce: nonce
        )
        Task {
            try await Auth.auth().signIn(with: cred)
            guard let uuid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("user").document(uuid)
                .getDocument()
            if !snapshot.exists {
                try await Firestore.firestore().collection("user").document(uuid).setData(["level": 1])
            }
            isSuccessSignin = true
        }
    }
}
