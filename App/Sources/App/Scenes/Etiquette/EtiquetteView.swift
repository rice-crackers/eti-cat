import SwiftUI

struct EtiquetteView: View {
    @StateObject var viewModel = EtiquetteViewModel()
    let columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 9) {
                    ForEach(viewModel.etiquetteList, id: \.id) { etiquette in
                        etiqutteRowView(etiquette: etiquette)
                    }
                }
                .padding(.vertical, 16)
            }
            .navigationTitle("에티켓사전")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 20)
            .background(EticatAsset.n50.swiftUIColor)
        }
    }

    @ViewBuilder
    func etiqutteRowView(etiquette: EtiquetteEntity) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(EticatAsset.n30.swiftUIColor)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .topLeading) {
                Text(etiquette.name)
                    .padding(16)
                    .font(.custom(EticatFontFamily.Suit.bold.name, size: 20))
            }
            .overlay(alignment: .bottomTrailing) {
                Image(etiquette.imageName)
                    .renderingMode(.original)
                    .padding(16)
                    .unredacted()
                    .opacity(viewModel.isLoaded ? 1 : 0)
            }
            .redacted(reason: viewModel.isLoaded ? [] : .placeholder)
    }
}

struct EtiquetteView_Previews: PreviewProvider {
    static var previews: some View {
        EtiquetteView()
    }
}
