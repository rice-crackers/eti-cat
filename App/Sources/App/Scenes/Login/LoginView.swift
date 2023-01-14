import AuthenticationServices
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            EticatAsset.loginBackground.swiftUIImage
                .ignoresSafeArea()

            VStack {
                Spacer()

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
                .padding(.bottom, 48)
            }
        }
        .onChange(of: viewModel.isSuccessSignin) { newValue in
            if newValue {
                appState.sceneFlow = .main
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
