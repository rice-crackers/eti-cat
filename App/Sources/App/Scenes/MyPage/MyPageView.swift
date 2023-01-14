import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

struct MyPageView: View {
    @AppStorage("LEVEL", store: .standard) var level = 1

    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(EticatAsset.n30.swiftUIColor)
                    .padding(.horizontal, 20)
                    .padding(.top, 32)
                    .frame(height: 168)
                    .overlay(alignment: .topLeading) {
                        Text("킹왕짱 고양이")
                            .font(.custom(EticatFontFamily.Suit.bold.name, size: 16))
                            .padding(20)
                    }
                    .overlay(alignment: .topTrailing) {
                        EticatAsset.crownCat.swiftUIImage
                            .renderingMode(.original)
                    }
                    .overlay(alignment: .bottom) {
                        HStack {
                            ForEach(0..<8) { index in
                                if index == 0 {
                                    Rectangle()
                                        .fill(EticatAsset.n10.swiftUIColor)
                                        .cornerRadius(4, corners: [.topLeft, .bottomLeft])
                                } else if index == 7 {
                                    Rectangle()
                                        .fill(EticatAsset.n10.swiftUIColor)
                                        .cornerRadius(4, corners: [.topRight, .bottomRight])
                                }
                            }
                        }
                        .padding(.bottom, 30)
                        .padding(.horizontal, 20)
                    }

                Spacer()
            }
            .task {
                try? await onAppear()
            }
            .navigationTitle("마이")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func onAppear() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let doc = try await Firestore.firestore().collection("user").document(uid).getDocument()
        let item = doc.data()?["level"] as? Int ?? 1
        level = item
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
