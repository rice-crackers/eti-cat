import SwiftUI
import NukeUI
import MarkdownUI

struct SolutionByStepView: View {
    @StateObject var viewModel = SolutionByStepViewModel()
    @AppStorage("LEVEL", store: .standard) var level = 1
    
    @Namespace private var animation
    @State private var currentItem: SolutionEntity?
    @State private var isDetailShow: Bool = false
    @State var loadingMarkdown = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ZStack {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.solutionList, id: \.id) { solution in
                            solutionByStepRowView(solution: solution)
                                .transition(.opacity)
                                .onTapGesture {
                                    currentItem = solution
                                    withAnimation { isDetailShow = true }
                                }
                                .fullScreenCover(isPresented: $isDetailShow) {
                                    if let currentItem, isDetailShow {
                                        detailView(solution: currentItem)
                                    }
                                }
                            
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("단계별 풀이")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, isDetailShow ? 0 : 20)
            .background(EticatAsset.n50.swiftUIColor)
            .statusBarHidden(isDetailShow)
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
            .blur(radius: level < solution.level ? 8 : 0)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(alignment: .top) {
                if level < solution.level {
                    VStack(spacing: 4) {
                        Image("Lock").resizable().frame(width: 56, height: 56)
                        Text("잠겨있다냥").font(.custom(EticatFontFamily.Suit.bold.name, size: 20))
                    }
                    .padding(.top, 48)
                }
            }
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
                    withAnimation { isDetailShow = false }
                }
        }
        .overlay {
            ZStack {
                Rectangle().fill(EticatAsset.n50.swiftUIColor).frame(height: 108)
                Button {
                    // ADD!
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(EticatAsset.p2.swiftUIColor)
                        .frame(height: 52)
                        .padding(.horizontal, 20)
                        .overlay(alignment: .center) {
                            Text("문제풀이")
                                .font(.custom(EticatFontFamily.Suit.bold.name, size: 14))
                                .foregroundColor(EticatAsset.dark.swiftUIColor)
                        }
                        .opacity(loadingMarkdown ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
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

import WebKit

struct DMarkdownView: UIViewRepresentable {
    var markdown: String

    init(styleMarkdown: String) {
        self.markdown = styleMarkdown
    }

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.markdown) else {
            return WKWebView()
        }

        let markView = WKWebView()
        let markdownText = URLRequest(url: url)

        DispatchQueue.main.async {
            markView.load(markdownText)
        }
        return markView
    }

    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<DMarkdownView>) {}
}
