import Foundation

struct Character: Identifiable, Equatable {
    let id: String
    let name: String
    /// SF Symbol name used as placeholder avatar.
    let avatarSymbol: String

    static let all: [Character] = [
        Character(id: "1", name: "Alex", avatarSymbol: "person.circle.fill"),
        Character(id: "2", name: "Sam", avatarSymbol: "person.crop.circle.fill"),
        Character(id: "3", name: "Jordan", avatarSymbol: "person.fill"),
        Character(id: "4", name: "Riley", avatarSymbol: "person.crop.circle.badge.checkmark"),
        Character(id: "5", name: "Morgan", avatarSymbol: "person.crop.circle.fill.badge.plus")
    ]
}
