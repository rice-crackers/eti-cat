import Combine
import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
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
            print("ASD")
        }
    }
}
