import SwiftUI

struct ComparisonView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    private var firstPlaythrough: Playthrough? {
        appState.playthroughs.count >= 1 ? appState.playthroughs[0] : nil
    }
    
    private var secondPlaythrough: Playthrough? {
        appState.playthroughs.count >= 2 ? appState.playthroughs[1] : nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    // Header
                    VStack(spacing: 16) {
                        Text("Same Town. Same Morning.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("The town didn't change. The experience did.")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    // Comparison cards
                    if let first = firstPlaythrough, let second = secondPlaythrough {
                        HStack(spacing: 20) {
                            ComparisonCard(playthrough: first, isLeft: true)
                            ComparisonCard(playthrough: second, isLeft: false)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Bottom message
                    Text("One place can feel completely different depending on who you are.")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 40)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Continue Exploring") {
                        appState.playthroughs.removeAll()
                        appState.showPerspectiveComparison = false
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

struct ComparisonCard: View {
    let playthrough: Playthrough
    let isLeft: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // Avatar and name
            VStack(spacing: 12) {
                Image(systemName: playthrough.character.avatarName)
                    .font(.system(size: 48))
                    .foregroundStyle(.primary)
                
                Text(playthrough.character.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(playthrough.character.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // Comparison bullets
            VStack(spacing: 12) {
                ForEach(0..<min(3, playthrough.snippets.count), id: \.self) { index in
                    HStack {
                        if isLeft {
                            Text("•")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(playthrough.snippets[index].text)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(playthrough.snippets[index].text)
                                .font(.subheadline)
                                .multilineTextAlignment(.trailing)
                            Text("•")
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            
            // Emotional outcome
            Text("Felt \(playthrough.emotionalTone) by the end of the morning")
                .font(.subheadline)
                .italic()
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}