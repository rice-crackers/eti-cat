import SwiftUI

struct EtiquetteView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    let data = [
        "메일",
        "회의",
        "명함",
        "인사",
        "운전",
        "전화",
        "흡연",
        "식사"
    ]
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 9) {
                    ForEach(data, id: \.self) { item in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(EticatAsset.n30.swiftUIColor)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(alignment: .topLeading) {
                                Text(item)
                                    .padding(16)
                            }
                    }
                }
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
