import SwiftUI

struct QuizeView: View {
    @Environment(\.presentations) var presentations
    @State var isPresentedFailed = false
    @State var isSuccess = false
    var body: some View {
        TabView {
            EticatAsset.quizScreen1.swiftUIImage
                .ignoresSafeArea()
                .onTapGesture {
                    isPresentedFailed = true
                }
            
            EticatAsset.quizScreen2.swiftUIImage
                .ignoresSafeArea()
            
            EticatAsset.quizScreen3.swiftUIImage
                .ignoresSafeArea()
                .onTapGesture {
                    isSuccess = true
                }
        }
        .fullScreenCover(isPresented: $isPresentedFailed) {
            EticatAsset.ggabi.swiftUIImage
                .ignoresSafeArea()
                .onTapGesture {
                    isPresentedFailed = false
                    presentations.forEach {
                        $0.wrappedValue = false
                    }
                }
        }
        .fullScreenCover(isPresented: $isSuccess) {
            EticatAsset.lgtm.swiftUIImage
                .ignoresSafeArea()
                .onTapGesture {
                    isSuccess = false
                    presentations.forEach {
                        $0.wrappedValue = false
                    }
                }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct QuizeView_Previews: PreviewProvider {
    static var previews: some View {
        QuizeView()
    }
}
