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
                    .frame(height: 196)
                    .overlay(alignment: .topLeading) {
                        Text("킹왕짱 고양이")
                            .font(.custom(EticatFontFamily.Suit.bold.name, size: 16))
                            .padding([.top, .leading], 20)
                    }
                    .overlay(alignment: .topTrailing) {
                        EticatAsset.crownCat.swiftUIImage
                            .renderingMode(.original)
                            .padding([.top, .trailing], 20)
                    }
                    .overlay(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("\(String(format: "%.1f", (Double(level)/8.0) * 100))%")

                            HStack(spacing: 0) {
                                ForEach(0..<8) { index in
                                    Group {
                                        if index == 0 {
                                            Rectangle()
                                                .fill(level <= index ? EticatAsset.n10.swiftUIColor : EticatAsset.p2.swiftUIColor)
                                                .cornerRadius(4, corners: [.topLeft, .bottomLeft])
                                        } else if index == 7 {
                                            Rectangle()
                                                .fill(level <= index ? EticatAsset.n10.swiftUIColor : EticatAsset.p2.swiftUIColor)
                                                .cornerRadius(4, corners: [.topRight, .bottomRight])
                                        } else {
                                            Rectangle()
                                                .fill(level <= index ? EticatAsset.n10.swiftUIColor : EticatAsset.p2.swiftUIColor)
                                        }
                                    }
                                    .frame(height: 16)
                                    .frame(maxWidth: .infinity)

                                    if index != 7 {
                                        Rectangle()
                                            .fill(EticatAsset.n20.swiftUIColor)
                                            .frame(width: 1, height: 16)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 32)

                RoundedRectangle(cornerRadius: 24)
                    .fill(EticatAsset.n30.swiftUIColor)
                    .frame(height: 53)
                    .overlay {
                        HStack {
                            Text("로그아웃")

                            Spacer()

                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 9, height: 17)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

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
        
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
