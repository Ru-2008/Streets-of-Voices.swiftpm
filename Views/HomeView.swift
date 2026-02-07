import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            Text("Streets of Voices")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Experience one town through many lives.")
                .foregroundColor(.secondary)

            Button("Start Day") {
                // later logic
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
