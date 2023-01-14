import AuthenticationServices
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = []
                let nonce = FirebaseAppleUtils.randomNonceString()
                request.nonce = FirebaseAppleUtils.sha256(nonce)
                viewModel.nonce = nonce
            } onCompletion: { res in
                switch res {
                case let .success(authorization):
                    guard let cred = authorization.credential as? ASAuthorizationAppleIDCredential else {
                        return
                    }
                    viewModel.appleSigninCompleted(idData: cred.identityToken ?? .init())

                case let .failure(err):
                    print(err)
                }
            }
            .signInWithAppleButtonStyle(.white)
            .frame(height: 50)
            .padding(.horizontal, 20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
