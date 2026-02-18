import SwiftUI

struct Playthrough: Identifiable, Equatable {
    let id = UUID()
    let character: Character
    let snippets: [SummarySnippet]
    let emotionalTone: String
}

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    @Published var selectedTab: MainTab = .home
    @Published var stats: Stats = Stats()
    @Published var startingStats: Stats = Stats()
    @Published var summarySnippets: [SummarySnippet] = []
    @Published var dayEnded: Bool = false
    @Published var selectedCharacter: Character?
    @Published var playthroughs: [Playthrough] = []
    @Published var showComparison: Bool = false
    @Published var showPerspectiveComparison: Bool = false
    @Published var showScanner: Bool = false
    @Published var scannedLocationID: String?

    func completeOnboarding() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
    }

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
            // Determine emotional tone for this playthrough
            // (Reusing logic that was in SummaryView, ideally should be a shared helper or on Playthrough)
            // For now, let's just use a placeholder or move the logic here if possible.
            // Actually, best to calculate it in View or make a helper. 
            // Let's assume passed in or calculated. 
            // Since we don't have the logic here, I will add a helper method to AppState or Playthrough.
            let tone = determineEmotionalTone(from: summarySnippets)
            
            let playthrough = Playthrough(character: character, snippets: summarySnippets, emotionalTone: tone)
            
            if !playthroughs.contains(where: { $0.character.id == character.id }) {
                playthroughs.append(playthrough)
            }
            
            if playthroughs.count == 2 {
                showPerspectiveComparison = true
            }
        }
    }

    private func determineEmotionalTone(from snippets: [SummarySnippet]) -> String {
        let snippetTexts = snippets.map { $0.text.lowercased() }
        var positiveCount = 0
        var negativeCount = 0
        
        for text in snippetTexts {
            if text.contains("friendly") || text.contains("help") || text.contains("appreciat") || text.contains("rest") || text.contains("goodbye") {
                positiveCount += 1
            } else if text.contains("leave") || text.contains("exhaustion") || text.contains("barrier") {
                negativeCount += 1
            }
        }
        
        if positiveCount > negativeCount {
            return "positive"
        } else if negativeCount > positiveCount {
            return "challenging"
        } else {
            return "balanced"
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
