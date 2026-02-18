import Foundation

struct Location: Identifiable, Equatable {
    let id: String
    let name: String
    /// SF Symbol name for the location button.
    let symbol: String
    let description: String
    /// Character IDs that can access this location. Empty means all characters can access.
    let accessibleByCharacterIds: [String]
    /// First scene to show when entering this location; nil shows placeholder content.
    let startSceneID: String?
    /// Relative position for placement on the map (x: 0-1, y: 0-1)
    let mapPosition: CGPoint

    /// Returns true if the character can access this location.
    func isAccessible(by character: Character) -> Bool {
        if accessibleByCharacterIds.isEmpty { return true }
        return accessibleByCharacterIds.contains(character.id)
    }

    @MainActor static let all: [Location] = LocationsData.shared.locations
}
