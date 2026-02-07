import SwiftUI

@MainActor
struct CharacterSelectView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Character.all) { character in
                    CharacterCard(
                        character: character,
                        isSelected: appState.selectedCharacter?.id == character.id
                    ) {
                        appState.selectCharacter(character)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

struct CharacterCard: View {
    let character: Character
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: character.avatarName)
                        .font(.title)
                        .foregroundStyle(isSelected ? Color.accentColor : .secondary)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(character.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(character.role)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fontWeight(.medium)
                }
                
                Text("\(character.age) years old")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(character.shortBio)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(character.mindset)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .italic()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .frame(width: 160, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.accentColor : .clear, lineWidth: 3)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
