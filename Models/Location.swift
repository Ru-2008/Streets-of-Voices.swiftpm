import Foundation

struct Location: Identifiable, Equatable {
    let id: String
    let name: String
    /// SF Symbol name for the location button.
    let symbol: String
    /// Character IDs that can access this location. Empty means all characters can access.
    let accessibleByCharacterIds: [String]
    /// First scene to show when entering this location; nil shows placeholder content.
    let startSceneID: String?

    /// Returns true if the character can access this location.
    func isAccessible(by character: Character) -> Bool {
        if accessibleByCharacterIds.isEmpty { return true }
        return accessibleByCharacterIds.contains(character.id)
    }

    static let all: [Location] = [
        Location(id: "library", name: "Library", symbol: "books.vertical.fill", accessibleByCharacterIds: ["1", "3", "5"], startSceneID: "library-intro"),
        Location(id: "park", name: "Park", symbol: "leaf.fill", accessibleByCharacterIds: [], startSceneID: "park-intro"),
        Location(id: "square", name: "Town Square", symbol: "building.columns.fill", accessibleByCharacterIds: [], startSceneID: nil),
        Location(id: "cafe", name: "Café", symbol: "cup.and.saucer.fill", accessibleByCharacterIds: ["1", "2", "4", "5"], startSceneID: nil),
        Location(id: "hall", name: "Town Hall", symbol: "building.2.fill", accessibleByCharacterIds: ["2", "3", "4"], startSceneID: nil)
    ]
}
