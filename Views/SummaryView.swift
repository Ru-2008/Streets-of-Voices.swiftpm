import SwiftUI

struct SummaryView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                timelineSection(state: appState)
                statsSection(state: appState)
                reflectionSection
            }
            .padding()
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
