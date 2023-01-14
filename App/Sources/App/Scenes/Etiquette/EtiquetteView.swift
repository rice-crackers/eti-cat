import SwiftUI

struct EtiquetteView: View {
    @StateObject var viewModel = EtiquetteViewModel()
    let columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 9) {
                    ForEach(viewModel.etiquetteList, id: \.name) { etiquette in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(EticatAsset.n30.swiftUIColor)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(alignment: .topLeading) {
                                Text(etiquette.name)
                                    .padding(16)
                                    .font(.custom(EticatFontFamily.Suite.bold.name, size: 20))
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Image(etiquette.imageName)
                                    .renderingMode(.original)
                                    .padding(16)
                            }
                    }
                }
                .padding(.top, 16)
            }
            .navigationTitle("에티켓사전")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 20)
        }
    }
}

struct EtiquetteView_Previews: PreviewProvider {
    static var previews: some View {
        EtiquetteView()
    }
}
