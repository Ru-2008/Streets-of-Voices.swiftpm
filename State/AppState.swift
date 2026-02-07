import SwiftUI

/// Global app state: onboarding completion, tab selection, character, stats, and day.
/// Persists onboarding so it is shown only once.
final class AppState: ObservableObject {
    @AppStorage("hasStarted") var hasStarted: Bool = false
    @Published var showOnboarding: Bool = false
    @Published var selectedTab: MainTab = .home
    @Published var stats: Stats = Stats()
    @Published var startingStats: Stats = Stats()
    @Published var summarySnippets: [SummarySnippet] = []
    @Published var dayEnded: Bool = false
    @Published var selectedCharacter: Character?

    /// Selects a character and resets stats, snippets, and day state.
    func selectCharacter(_ character: Character) {
        selectedCharacter = character
        stats = Stats()
        startingStats = Stats()
        summarySnippets = []
        dayEnded = false
    }

    /// Records a chosen snippet for the summary timeline (e.g. when making a scene choice).
    func addSummarySnippet(_ text: String) {
        let order = summarySnippets.count
        summarySnippets.append(SummarySnippet(order: order, text: text))
    }
}

enum MainTab: Int, CaseIterable {
    case home = 0
    case characters = 1
    case town = 2
    case summary = 3
    case about = 4

    var title: String {
        switch self {
        case .home: return "Home"
        case .characters: return "Characters"
        case .town: return "Town"
        case .summary: return "Summary"
        case .about: return "About"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .characters: return "person.2.fill"
        case .town: return "building.2.fill"
        case .summary: return "doc.text.fill"
        case .about: return "info.circle.fill"
        }
    }
}
