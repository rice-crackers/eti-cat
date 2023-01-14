import SwiftUI

struct SolutionByStepView: View {
    @StateObject var viewModel = SolutionByStepViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.solutionList, id: \.level) { solution in
                        solutionByStepRowView(solution: solution)
                    }
                }
                .padding(.top, 16)
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
                .font(.custom(EticatFontFamily.Suite.bold.name, size: 16))
                .padding(.bottom, 8)
            
            AsyncImage(url: URL(string: solution.bannerURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 264)
                    .cornerRadius(26)
                
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .frame(height: 264)
            }
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(EticatAsset.n30.swiftUIColor)
                .frame(height: 84)
                .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 6) {
                Text(solution.title)
                    .font(.custom(EticatFontFamily.Suite.bold.name, size: 20))
                Text(solution.description)
                    .font(.custom(EticatFontFamily.Suite.medium.name, size: 14))
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
    }
}

struct SolutionByStepView_Previews: PreviewProvider {
    static var previews: some View {
        SolutionByStepView()
    }
}
