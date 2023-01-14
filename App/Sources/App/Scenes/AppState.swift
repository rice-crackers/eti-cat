import Combine
import FirebaseAuth

final class AppState: ObservableObject {
    @Published var sceneFlow = SceneState.login

    init() {
        sceneFlow = Auth.auth().currentUser == nil ? .login : .main
    }
}
