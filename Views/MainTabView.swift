import SwiftUI

struct MainTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeTabView(appState: appState)
                .tabItem { tabLabel(.home) }
                .tag(MainTab.home)

            CharactersTabView(appState: appState)
                .tabItem { tabLabel(.characters) }
                .tag(MainTab.characters)

            TownTabView(appState: appState)
                .tabItem { tabLabel(.town) }
                .tag(MainTab.town)

            SummaryTabView(appState: appState)
                .tabItem { tabLabel(.summary) }
                .tag(MainTab.summary)

            AboutTabView()
                .tabItem { tabLabel(.about) }
                .tag(MainTab.about)
        }
        .onChange(of: appState.selectedTab) { _, newValue in
            if newValue == .summary, !appState.dayEnded {
                appState.selectedTab = .home
            }
        }
    }

    private func tabLabel(_ tab: MainTab) -> Label<Text, Image> {
        Label(tab.title, systemImage: tab.systemImage)
    }
}

struct HomeTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let character = appState.selectedCharacter {
                    Text("\(character.name)'s day")
                        .font(.title2)
                } else {
                    Text("Choose a character to begin.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Button("Start Experience") {
                    appState.showOnboarding = true
                }
                .buttonStyle(.bordered)
                if appState.selectedCharacter != nil, !appState.dayEnded {
                    Button("End day") {
                        appState.dayEnded = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Home")
        }
    }
}

struct CharactersTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationStack {
            CharacterSelectView(appState: appState)
                .navigationTitle("Characters")
        }
    }
}

struct TownTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationStack {
            TownMapView(appState: appState)
                .navigationTitle("Town")
        }
    }
}

struct SummaryTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationStack {
            Group {
                if appState.dayEnded {
                    SummaryView(appState: appState)
                } else {
                    SummaryLockedView()
                }
            }
            .navigationTitle("Summary")
        }
    }
}

struct SummaryLockedView: View {
    var body: some View {
        ContentUnavailableView(
            "Day still in progress",
            systemImage: "sun.max",
            description: Text("Explore the town, then tap \"End day\" on Home to see your summary.")
        )
    }
}

struct AboutTabView: View {
    var body: some View {
        NavigationStack {
            AboutView()
                .navigationTitle("About")
        }
    }
}
