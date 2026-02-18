import SwiftUI

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool = false
    @Published var selectedTab: MainTab = .home
    @Published var stats: Stats = Stats()
    @Published var startingStats: Stats = Stats()
    @Published var summarySnippets: [SummarySnippet] = []
    @Published var dayEnded: Bool = false
    @Published var selectedCharacter: Character?
    @Published var completedCharacters: [Character] = []
    @Published var showComparison: Bool = false
    @Published var showScanner: Bool = false
    @Published var scannedLocationID: String?

    func selectCharacter(_ character: Character) {
        selectedCharacter = character
        stats = character.baseStats
        startingStats = character.baseStats
        summarySnippets = []
        dayEnded = false
    }

    func addSummarySnippet(_ text: String) {
        let order = summarySnippets.count
        summarySnippets.append(SummarySnippet(order: order, text: text))
    }
    
    func completeDay() {
        if let character = selectedCharacter {
            if !completedCharacters.contains(where: { $0.id == character.id }) {
                completedCharacters.append(character)
            }
            
            if completedCharacters.count == 2 {
                showComparison = true
            }
        }
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
