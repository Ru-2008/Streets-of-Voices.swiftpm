import SwiftUI

struct OnboardingView: View {
    @ObservedObject var appState: AppState
    @State private var currentPage = 0

    private let pages: [(title: String, subtitle: String, symbol: String)] = [
        ("Streets of Voices", "Discover stories from the town.", "map.fill"),
        ("Characters", "Meet the people who live here.", "person.2.fill"),
        ("Your Journey", "Explore, listen, and reflect.", "star.fill")
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    onboardingPage(
                        title: page.title,
                        subtitle: page.subtitle,
                        symbol: page.symbol
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))

            Button("Begin") {
                appState.hasStarted = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .navigationBarHidden(true)
    }

    private func onboardingPage(title: String, subtitle: String, symbol: String) -> some View {
        VStack(spacing: 24) {
            Image(systemName: symbol)
                .font(.system(size: 64))
                .foregroundStyle(.tint)
                .symbolRenderingMode(.hierarchical)

            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
