import Foundation

struct Stats: Equatable {
    var visits: Int
    var conversations: Int
    var discoveries: Int

    init(visits: Int = 0, conversations: Int = 0, discoveries: Int = 0) {
        self.visits = visits
        self.conversations = conversations
        self.discoveries = discoveries
    }

    /// Returns a new Stats with the given deltas applied (additive). No randomness.
    func applying(_ delta: Stats) -> Stats {
        Stats(
            visits: visits + delta.visits,
            conversations: conversations + delta.conversations,
            discoveries: discoveries + delta.discoveries
        )
    }
}
