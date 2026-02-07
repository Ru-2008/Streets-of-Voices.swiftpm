import Foundation

struct CharacterStory: Identifiable, Equatable {
    let id: String  // characterID
    let worldviewDescription: String
    let keyConcerns: [String]
    let emotionalTone: String
}