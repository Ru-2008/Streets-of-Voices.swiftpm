import SwiftUI

struct SummaryView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                emotionalSummarySection(state: appState)
                timelineSection(state: appState)
                statsSection(state: appState)
                reflectionSection
            }
            .padding()
        }
    }
    
    private func emotionalSummarySection(state: AppState) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How your day felt")
                .font(.headline)
            
            if let character = state.selectedCharacter {
                let emotionalTone = determineEmotionalTone(from: state.summarySnippets)
                Text("Today felt \(emotionalTone) because of the choices you made as \(character.name).")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Text("Choose a character to see emotional insights.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func determineEmotionalTone(from snippets: [SummarySnippet]) -> String {
        // Simple algorithm to determine emotional tone from summary snippets
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

    private func timelineSection(state: AppState) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your day")
                .font(.headline)
            if state.summarySnippets.isEmpty {
                Text("No moments recorded yet.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(state.summarySnippets) { snippet in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(snippet.order + 1)")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                                .frame(width: 20, alignment: .leading)
                            Text(snippet.text)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
    }

    private func statsSection(state: AppState) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Starting vs ending")
                .font(.headline)
            HStack(spacing: 24) {
                statBlock(title: "Starting", stats: state.startingStats)
                statBlock(title: "Ending", stats: state.stats)
            }
        }
    }

    private func statBlock(title: String, stats: Stats) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Visits: \(stats.visits)")
            Text("Conversations: \(stats.conversations)")
            Text("Discoveries: \(stats.discoveries)")
        }
        .font(.subheadline)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private var reflectionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reflection")
                .font(.headline)
            Text("What stayed with you today?")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
