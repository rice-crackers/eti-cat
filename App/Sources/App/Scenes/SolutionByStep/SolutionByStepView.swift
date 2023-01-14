import SwiftUI
import NukeUI
import MarkdownUI

struct SolutionByStepView: View {
    @StateObject var viewModel = SolutionByStepViewModel()
    
    @Namespace private var animation
    @State private var currentItem: SolutionEntity?
    @State private var isDetailShow: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if !isDetailShow {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.solutionList, id: \.id) { solution in
                            solutionByStepRowView(solution: solution)
                                .transition(.opacity)
                                .matchedGeometryEffect(id: solution.id, in: animation)
                                .onTapGesture {
                                    currentItem = solution
                                    withAnimation { isDetailShow = true }
                                }
                            
                        }
                    }
                    .padding(.vertical, 16)
                }
                if let currentItem, isDetailShow {
                    detailView(solution: currentItem)
                        .edgesIgnoringSafeArea(.all)
                        .navigationTitle("")
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(20)
                                .onTapGesture {
                                    withAnimation { isDetailShow = false }
                                }
                        }
                }
            }
            .navigationTitle(isDetailShow ? "" : "단계별 풀이")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, isDetailShow ? 0 : 20)
            .background(EticatAsset.n50.swiftUIColor)
        }
    }
    
    @ViewBuilder
    func solutionByStepRowView(solution: SolutionEntity) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Level \(solution.level)")
                .font(.custom(EticatFontFamily.Suit.bold.name, size: 16))
                .padding(.bottom, 8)
            
            LazyImage(
                url: URL(string: solution.bannerURL),
                resizingMode: .aspectFill
            )
            .frame(width: UIScreen.main.bounds.width - 40 , height: 264)
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
            
            Text(try! AttributedString(
                styledMarkdown: """
                                                        # 식사 예절

                                                        직장 생활이나 비즈니스를 하다보면 정말 다양한 사람들과 식사를 하게 되는 경우가 생긴다. 사무실이나 회의실과는 달리 식사자리에서는 보다 마음편히 상대방을 대할 수 있는 장점이 있지만 자칫 잘못하다가는 무례한 사람으로 낙인찍혀 이미지에 큰 손상을 입기도 하는데요. 따라서 긍정적이고 호감있는 이미지를 심어줄 수 있도록 식사예절을 미리 숙지해두는 것이 좋습니다.

                                                        ---

                                                        ## 식사 전

                                                        비즈니스 관계에 있는 상대방과 식사를 하게 될 상황이 생기면 미리 레스토랑을 예약해두는 것이 기본적인 식사예절이다.

                                                        약속장소 근처 괜찮은 식당을 검색하여 선정하는 것이 좋으며, 약속 3~7일 전 넉넉하게 예약을 해두는 것이 좋다.

                                                        약속 당일에는 식사 장소의 분위기와 상대방과의 관계를 고려하여 격식 있는 복장을 갖추는 것이 비즈니스 매너에 좋다(특히 여성의 경우 좌식이 불편할 수 있으니 자리의 형태를 미리 확인해보는 센스가 필요함).

                                                        ## 식사 중

                                                        상대방과 만나 식사 장소에 착석하게 되면 식사와 대화에 집중할 수 있도록 휴대폰은 꺼두고 물수건으로는 손만 닦도록 한다.

                                                        해당 식사 장소의 인기 메뉴를 미리 기억해두고 권해드리는 것도 좋지만, 준비하지 못했다면 상대방이 메뉴를 고를 수 있도록 배려하는 것도 식사 예절의 중요한 부분이다.

                                                        기본적으로 쩝쩝/후루룩거리는 소리를 내거나, 반찬을 뒤적이는 행동, 입에 음식을 머금은 채로 이야기를 하는 행위는 삼가야 한다.

                                                        디테일한 부분으론 상대방 속도에 맞춰 식사를 하고, 식사 도중 뼈나 껍질이 나왔을 때 상대방이 보이지 않는 곳으로 휴지 위에 모아두는 것이 좋다.

                                                        함께 나눠먹는 음식이라면 입에 넣은 숟가락을 넣기 보다는 각자 앞접시를 사용하여 먹을만큼 떠 먹는 것이 청결한 인상을 심어줄 수 있습니다.

                                                        ## 식사 후

                                                        함께 식사하는 자리에 나보다 윗사람이 계시다면, 그 분이 식사를 끝마칠 때까지 일어서지 않고 기다려야 하며 가능하면 식사속도를 맞춰 함께 수저를 놓도록 해야 한다.

                                                        부득이하게 먼저 식사가 끝났다면 윗사람이 식사를 마치기 전까지 밥그릇에 수저를 올려두고 있어야 하며, 식사가 모두 끝난 후에 상 위에 수저를 내려놓는 것이 좋다.

                                                        비즈니스 자리라면 이쑤시개 사용을 자제하도록 해야 하며, 입 안이 불편하다면 양해를 구하고 화장실에서 해결하는 것이 좋다.

                                                        식사비용은 초대한 입장에서 지불하는 것이 상식이며, 식사도중 청구서가 들어오지 않도록 미리 식사장소 측에 양해를 구하는 것도 식사예절 중 하나이다.
                                                        
"""))
                .font(.custom(EticatFontFamily.Suit.medium.name, size: 16))
        }
        .matchedGeometryEffect(id: solution.id, in: animation)
        .background(EticatAsset.n50.swiftUIColor)
    }
}

extension AttributedString {
    init(styledMarkdown markdownString: String) throws {
        var output = try AttributedString(
            markdown: markdownString,
            options: .init(
                allowsExtendedAttributes: true,
                interpretedSyntax: .full,
                failurePolicy: .returnPartiallyParsedIfPossible
            ),
            baseURL: nil
        )

        for (intentBlock, intentRange) in output.runs[AttributeScopes.FoundationAttributes.PresentationIntentAttribute.self].reversed() {
            guard let intentBlock = intentBlock else { continue }
            for intent in intentBlock.components {
                switch intent.kind {
                case .header(level: let level):
                    switch level {
                    case 1:
                        output[intentRange].font = .system(.title).bold()
                    case 2:
                        output[intentRange].font = .system(.title2).bold()
                    case 3:
                        output[intentRange].font = .system(.title3).bold()
                    default:
                        break
                    }
                default:
                    break
                }
            }
            
            if intentRange.lowerBound != output.startIndex {
                output.characters.insert(contentsOf: "\n", at: intentRange.lowerBound)
            }
        }

        self = output
    }
}
