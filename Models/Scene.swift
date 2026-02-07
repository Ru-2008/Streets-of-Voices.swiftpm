import Foundation

struct Scene: Identifiable, Equatable {
    let id: String
    let text: String
    /// Exactly 2–3 choices per scene.
    let choices: [SceneChoice]

    static func find(id: String?) -> Scene? {
        guard let id = id else { return nil }
        return Self.byId[id]
    }

    static let byId: [String: Scene] = {
        let list: [Scene] = [
            Scene(
                id: "library-intro",
                text: "The library is quiet. Shelves line the walls and a librarian smiles from the desk.",
                choices: [
                    SceneChoice(label: "Look around the shelves", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), nextSceneID: "library-browse"),
                    SceneChoice(label: "Say hello to the librarian", statDelta: Stats(visits: 1, conversations: 1, discoveries: 0), nextSceneID: "library-talk"),
                    SceneChoice(label: "Leave", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), nextSceneID: nil)
                ]
            ),
            Scene(
                id: "library-browse",
                text: "You walk along the aisles. One book catches your eye.",
                choices: [
                    SceneChoice(label: "Pick it up and read", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), nextSceneID: nil),
                    SceneChoice(label: "Go back to the desk", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), nextSceneID: "library-intro")
                ]
            ),
            Scene(
                id: "library-talk",
                text: "The librarian tells you about the history of the building. You feel a little more at home here.",
                choices: [
                    SceneChoice(label: "Thank them and browse", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), nextSceneID: "library-browse"),
                    SceneChoice(label: "Say goodbye and leave", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), nextSceneID: nil)
                ]
            ),
            Scene(
                id: "park-intro",
                text: "The park is green and calm. A path leads further in.",
                choices: [
                    SceneChoice(label: "Follow the path", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), nextSceneID: "park-bench"),
                    SceneChoice(label: "Sit on the nearest bench", statDelta: Stats(visits: 1, conversations: 0, discoveries: 1), nextSceneID: nil)
                ]
            ),
            Scene(
                id: "park-bench",
                text: "At the end of the path you find a quiet bench. Someone has left a bookmark on the seat.",
                choices: [
                    SceneChoice(label: "Take the bookmark", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), nextSceneID: nil),
                    SceneChoice(label: "Leave it and head back", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), nextSceneID: "park-intro")
                ]
            )
        ]
        return Dictionary(uniqueKeysWithValues: list.map { ($0.id, $0) })
    }()
}

struct SceneChoice: Equatable {
    let label: String
    let statDelta: Stats
    /// Next scene to show; nil means end of scene.
    let nextSceneID: String?
}
