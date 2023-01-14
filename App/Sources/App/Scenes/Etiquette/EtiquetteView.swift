import SwiftUI
import NukeUI

struct EtiquetteView: View {
    @StateObject var viewModel = EtiquetteViewModel()
    @State var loadingMarkdown = false
    let columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 9) {
                    ForEach(viewModel.etiquetteList, id: \.id) { etiquette in
                        Button {
                            viewModel.etiquetteDidTap(etiquette: etiquette)
                        } label: {
                            etiqutteRowView(etiquette: etiquette)
                        }
                        .fullScreenCover(isPresented: $viewModel.isDetailShow) {
                            if let solution = viewModel.selectedSolution {
                                detailView(solution: solution)
                            }
                        }
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

    @ViewBuilder
    func detailView(solution: SolutionEntity) -> some View {
        ScrollView(showsIndicators: true) {
            VStack(spacing: 0) {
                LazyImage(url: URL(string: solution.bannerURL))
                    .frame(height: 264)
            }
            .overlay(alignment: .bottom) {
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(gradient: Gradient(colors: [.clear, EticatAsset.n50.swiftUIColor]),
                                   startPoint: .top, endPoint: .bottom)
                    .frame(height: 120)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(solution.title)
                            .font(.custom(EticatFontFamily.Suit.bold.name, size: 24))
                        Text(solution.description)
                            .font(.custom(EticatFontFamily.Suit.medium.name, size: 16))
                    }
                    .padding(20)
                }
            }
            
            DMarkdownView(styleMarkdown: solution.content)
                .frame(width: UIScreen.main.bounds.width, height: 650)
                .opacity(loadingMarkdown ? 1 : 0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
                        withAnimation { loadingMarkdown = true }
                    }
                }
        }
        .padding(.bottom, 20)
        .background(EticatAsset.n50.swiftUIColor)
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(20)
                .onTapGesture {
                    loadingMarkdown = false
                    withAnimation { viewModel.isDetailShow = false }
                }
        }
    }
}

struct EtiquetteView_Previews: PreviewProvider {
    static var previews: some View {
        EtiquetteView()
    }
}
