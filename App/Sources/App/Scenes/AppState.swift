import Combine
import FirebaseAuth

final class AppState: ObservableObject {
    @Published var sceneFlow = SceneState.login

    init() {
        sceneFlow = .login
    }
}
