import SwiftUI

struct ComparisonView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    private var firstCharacter: Character? {
        appState.completedCharacters.count >= 1 ? appState.completedCharacters[0] : nil
    }
    
    private var secondCharacter: Character? {
        appState.completedCharacters.count >= 2 ? appState.completedCharacters[1] : nil
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
                    if let first = firstCharacter, let second = secondCharacter {
                        HStack(spacing: 20) {
                            ComparisonCard(character: first, isLeft: true)
                            ComparisonCard(character: second, isLeft: false)
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
                        appState.completedCharacters.removeAll()
                        appState.showComparison = false
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

struct ComparisonCard: View {
    let character: Character
    let isLeft: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            // Avatar and name
            VStack(spacing: 12) {
                Image(systemName: character.avatarName)
                    .font(.system(size: 48))
                    .foregroundStyle(.primary)
                
                Text(character.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(character.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // Comparison bullets
            VStack(spacing: 12) {
                ForEach(0..<min(3, appState.summarySnippets.count), id: \.self) { index in
                    HStack {
                        if isLeft {
                            Text("•")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(appState.summarySnippets[index].text)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(appState.summarySnippets[index].text)
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
            Text("Felt \(character.emotionalBaseline) by the end of the morning")
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