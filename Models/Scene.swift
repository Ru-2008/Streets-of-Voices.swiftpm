import Foundation

struct Scene: Identifiable, Equatable {
    let id: String
    let text: String
    let innerThought: String?
    let limitationNote: String?
    let emotionalImpact: String
    let characterID: String
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
                innerThought: "I have to finish this chapter before the bell rings.",
                limitationNote: nil,
                emotionalImpact: "First impression of the library",
                characterID: "aarav",
                choices: [
                    SceneChoice(label: "Look around the shelves", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), emotionalNote: "Explored the library shelves", comparisonTag: "Explored quietly", nextSceneID: "library-browse"),
                    SceneChoice(label: "Say hello to the librarian", statDelta: Stats(visits: 1, conversations: 1, discoveries: 0), emotionalNote: "Had a friendly chat with librarian", comparisonTag: "Connected with staff", nextSceneID: "library-talk"),
                    SceneChoice(label: "Leave", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), emotionalNote: "Decided to leave the library", comparisonTag: "Left early", nextSceneID: nil)
                ]
            ),
            Scene(
                id: "library-intro-rohan",
                text: "The library is quiet. The aisles between the shelves look narrow from here.",
                innerThought: "I hope I can turn around in those aisles.",
                limitationNote: "The aisles are adjustable width.",
                emotionalImpact: "Assessed library accessibility",
                characterID: "rohan",
                choices: [
                    SceneChoice(label: "Check the aisle width", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), emotionalNote: "Checked for accessibility", comparisonTag: "Checked access", nextSceneID: nil),
                    SceneChoice(label: "Ask librarian for help", statDelta: Stats(visits: 1, conversations: 1, discoveries: 0), emotionalNote: "Asked for assistance", comparisonTag: "Sought help", nextSceneID: nil)
                ]
            ),
            Scene(
                id: "library-browse",
                text: "You walk along the aisles. One book catches your eye.",
                innerThought: "I really shouldn't be spending time here, but...",
                limitationNote: nil,
                emotionalImpact: "Found an interesting book",
                characterID: "aarav",
                choices: [
                    SceneChoice(label: "Pick it up and read", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), emotionalNote: "Took time to read interesting book", comparisonTag: "Found something special", nextSceneID: nil),
                    SceneChoice(label: "Go back to the desk", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), emotionalNote: "Returned to the front desk", comparisonTag: "Went back to start", nextSceneID: "library-intro")
                ]
            ),
            Scene(
                id: "library-talk",
                text: "The librarian tells you about the history of the building. You feel a little more at home here.",
                innerThought: "It's nice to talk to someone who isn't pressuring me.",
                limitationNote: nil,
                emotionalImpact: "Learned about the library's history",
                characterID: "aarav",
                choices: [
                    SceneChoice(label: "Thank them and browse", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), emotionalNote: "Appreciated the librarian's help", comparisonTag: "Learned something new", nextSceneID: "library-browse"),
                    SceneChoice(label: "Say goodbye and leave", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), emotionalNote: "Polite farewell to the librarian", comparisonTag: "Left politely", nextSceneID: nil)
                ]
            ),
            Scene(
                id: "park-intro",
                text: "The park is green and calm. A path leads further in.",
                innerThought: "I hope the path is paved all the way through.",
                limitationNote: "The gravel path is difficult to navigate.",
                emotionalImpact: "Arrived at the peaceful park",
                characterID: "rohan",
                choices: [
                    SceneChoice(label: "Follow the path", statDelta: Stats(visits: 1, conversations: 0, discoveries: 0), emotionalNote: "Continued exploring the park", comparisonTag: "Explored the path", nextSceneID: "park-bench"),
                    SceneChoice(label: "Sit on the nearest bench", statDelta: Stats(visits: 1, conversations: 0, discoveries: 1), emotionalNote: "Took a rest on the bench", comparisonTag: "Found a resting spot", nextSceneID: nil)
                ]
            ),
            Scene(
                id: "park-bench",
                text: "At the end of the path you find a quiet bench. Someone has left a bookmark on the seat.",
                innerThought: "Finally, a place to rest where I don't feel in the way.",
                limitationNote: nil,
                emotionalImpact: "Found a thoughtful surprise at the bench",
                characterID: "rohan",
                choices: [
                    SceneChoice(label: "Take the bookmark", statDelta: Stats(visits: 0, conversations: 0, discoveries: 1), emotionalNote: "Kept the thoughtful bookmark", comparisonTag: "Kept a small treasure", nextSceneID: nil),
                    SceneChoice(label: "Leave it and head back", statDelta: Stats(visits: 0, conversations: 0, discoveries: 0), emotionalNote: "Left the bookmark for someone else", comparisonTag: "Left it for others", nextSceneID: "park-intro")
                ]
            )
        ]
        return Dictionary(uniqueKeysWithValues: list.map { ($0.id, $0) })
    }()
}

struct SceneChoice: Equatable {
    let label: String
    let statDelta: Stats
    let emotionalNote: String
    let comparisonTag: String
    /// Next scene to show; nil means end of scene.
    let nextSceneID: String?
}
