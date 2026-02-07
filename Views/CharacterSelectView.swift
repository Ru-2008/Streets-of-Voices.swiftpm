import SwiftUI

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
        }
    }
}

struct CharacterCard: View {
    let character: Character
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: character.avatarSymbol)
                    .font(.system(size: 56))
                    .foregroundStyle(isSelected ? Color.accentColor : .secondary)
                    .frame(width: 80, height: 80)
                    .background(Circle().fill(Color(.secondarySystemBackground)))

                Text(character.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            .frame(width: 120)
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
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
