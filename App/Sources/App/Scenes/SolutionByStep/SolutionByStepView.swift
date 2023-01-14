import SwiftUI

struct SolutionByStepView: View {
    @StateObject var viewModel = SolutionByStepViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.solutionList, id: \.id) { solution in
                        solutionByStepRowView(solution: solution)
                            .transition(.opacity)
                    }
                }
                .padding(.vertical, 16)
            }
            .navigationTitle("단계별 풀이")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 20)
            .background(EticatAsset.n50.swiftUIColor)
        }
    }
    
    @ViewBuilder
    func solutionByStepRowView(solution: SolutionEntity) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Level \(solution.level)")
                .font(.custom(EticatFontFamily.Suit.bold.name, size: 16))
                .padding(.bottom, 8)
            
            AsyncImage(
                url: URL(string: solution.bannerURL),
                transaction: Transaction(animation: .easeIn)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40 , height: 264)
                        .aspectRatio(contentMode: .fill)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .fill(EticatAsset.n40.swiftUIColor)
                        .frame(height: 264)
                }
            }
            .unredacted()
            .cornerRadius(25)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(EticatAsset.n30.swiftUIColor)
                .frame(height: 84)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 6) {
                Text(solution.title)
                    .font(.custom(EticatFontFamily.Suit.bold.name, size: 20))
                Text(solution.description)
                    .font(.custom(EticatFontFamily.Suit.medium.name, size: 14))
            }
            .padding(20)
        }
        .overlay(alignment: .bottomTrailing) {
            Circle()
                .fill(EticatAsset.n10.swiftUIColor)
                .frame(width: 64, height: 64)
                .overlay(Circle().stroke(EticatAsset.n30.swiftUIColor, lineWidth: 4))
                .overlay(alignment: .center) {
                    Image(solution.imageName)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding(.bottom, 52)
                .padding(.trailing, 20)
        }
        .redacted(reason: viewModel.isLoaded ? [] : .placeholder)
    }
}

struct SolutionByStepView_Previews: PreviewProvider {
    static var previews: some View {
        SolutionByStepView()
    }
}
