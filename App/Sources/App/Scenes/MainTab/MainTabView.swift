import SwiftUI

struct MainTabView: View {
    @State var tabSelection = 0
    var body: some View {
        TabView(selection: $tabSelection) {
            EtiquetteView()
                .tabItem {
                    VStack {
                        EticatAsset.etiquette.swiftUIImage
                            .renderingMode(.template)

                        Text("에티켓사전")
                    }
                }

            Text("단계별풀이")
                .tabItem {
                    VStack {
                        EticatAsset.solve.swiftUIImage
                            .renderingMode(.template)

                        Text("단계별풀이")
                    }
                }

            Text("마이")
                .tabItem {
                    VStack {
                        EticatAsset.person.swiftUIImage
                            .renderingMode(.template)

                        Text("마이")
                    }
                }
        }
        .tint(EticatAsset.white.swiftUIColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
