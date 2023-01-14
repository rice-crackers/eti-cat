import SwiftUI

struct QuizeView: View {
    var body: some View {
        TabView {
            EticatAsset.quizScreen1.swiftUIImage
            EticatAsset.quizScreen2.swiftUIImage
            EticatAsset.quizScreen3.swiftUIImage
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct QuizeView_Previews: PreviewProvider {
    static var previews: some View {
        QuizeView()
    }
}
