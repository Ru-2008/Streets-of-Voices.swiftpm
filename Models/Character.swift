import Foundation

struct Character: Identifiable, Equatable {
    let id: String
    let name: String
    let role: String
    let age: Int
    let shortBio: String
    let mindset: String
    let dailyGoal: String
    let avatarName: String
    let baseStats: Stats

    @MainActor static let all: [Character] = CharactersData.shared.characters
}
