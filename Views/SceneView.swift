import SwiftUI

struct SceneView: View {
    @Binding var sceneID: String?
    @ObservedObject var appState: AppState

    private var scene: Scene? {
        Scene.find(id: sceneID)
    }

    var body: some View {
        if let scene = scene {
            VStack(alignment: .leading, spacing: 24) {
                if let innerThought = scene.innerThought {
                    Text(innerThought)
                        .font(.callout)
                        .italic()
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)
                }
                
                if let limitationNote = scene.limitationNote {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        Text(limitationNote)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 8)
                }
                
                Text(scene.text)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(scene.choices.enumerated()), id: \.offset) { _, choice in
                        Button {
                            applyChoice(choice, state: appState)
                        } label: {
                            Text(choice.label)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.secondarySystemBackground))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        } else {
            ContentUnavailableView(
                "Scene not found",
                systemImage: "book.closed",
                description: Text("This scene is missing or has ended.")
            )
        }
    }

    private func applyChoice(_ choice: SceneChoice, state: AppState) {
        state.stats = state.stats.applying(choice.statDelta)
        state.addSummarySnippet(choice.emotionalNote)
        sceneID = choice.nextSceneID
    }
}
