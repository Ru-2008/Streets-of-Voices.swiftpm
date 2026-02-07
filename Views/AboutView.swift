import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                section(
                    title: "Purpose",
                    text: "Streets of Voices lets you experience the same town through different characters. By making choices as each person, you see how the same places and moments can feel different depending on who you are. The app is built to encourage empathy and reflection on how we all move through shared spaces in our own way."
                )
                section(
                    title: "Inspiration",
                    text: "I wanted to build something that highlights perspective. We often assume everyone sees the world the same way, but small differences in access, comfort, and belonging can change how a place feels. This app is a small invitation to consider that the street you walk down might not feel the same to everyone who walks it."
                )
                section(
                    title: "Swift Student Challenge",
                    text: "This app was created for the Swift Student Challenge. It is built entirely in SwiftUI, runs offline, and uses no external libraries — a focused project to learn and share an idea."
                )
            }
            .padding()
        }
    }

    private func section(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(text)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
