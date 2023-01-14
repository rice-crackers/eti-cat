import Foundation

struct SolutionEntity: Equatable {
    let id: UUID = UUID()
    let level: Int
    let bannerURL: String
    let title: String
    let description: String
    let imageName: String
    let content: String
    let isLocked: Bool
}
