import SwiftUI

struct MainTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeTabView(appState: appState)
                .tabItem { Label(MainTab.home.title, systemImage: MainTab.home.systemImage) }
                .tag(MainTab.home)

            CharactersTabView(appState: appState)
                .tabItem { Label(MainTab.characters.title, systemImage: MainTab.characters.systemImage) }
                .tag(MainTab.characters)

            TownTabView(appState: appState)
                .tabItem { Label(MainTab.town.title, systemImage: MainTab.town.systemImage) }
                .tag(MainTab.town)

            SummaryTabView(appState: appState)
                .tabItem { Label(MainTab.summary.title, systemImage: MainTab.summary.systemImage) }
                .tag(MainTab.summary)

            AboutTabView()
                .tabItem { Label(MainTab.about.title, systemImage: MainTab.about.systemImage) }
                .tag(MainTab.about)
        }
        .onChange(of: appState.selectedTab) { _, newValue in
            if newValue == .summary, !appState.dayEnded {
                appState.selectedTab = .home
            }
        }
    }
}

struct HomeTabView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    HeroCardView()
                    ExperienceHighlightsView()
                    PrimaryActionView(appState: appState)
                    if let character = appState.selectedCharacter {
                        ProgressSnapshotView(character: character)
                        if !appState.dayEnded {
                            Button("End day") {
                                appState.dayEnded = true
                                appState.completeDay()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Home")
            .fullScreenCover(isPresented: $appState.showComparison) {
                ComparisonView()
                    .environmentObject(appState)
            }
        }
    }
}

struct HeroCardView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "building.2.fill")
                .font(.system(size: 48))
                .foregroundStyle(.primary)
            
            Text("Streets Of Voices")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Live one day in the same town through different lives.")
                .font(.subheadline)
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

struct ExperienceHighlightsView: View {
    private let items: [(icon: String, label: String)] = [
        ("person.3.fill", "Different Lives"),
        ("map.fill", "Same Town"),
        ("arrow.triangle.2.circlepath", "Replayable Choices")
    ]
    
    var body: some View {
        HStack(spacing: 24) {
            ForEach(items, id: \.label) { item in
                VStack(spacing: 8) {
                    Image(systemName: item.icon)
                        .font(.title2)
                        .foregroundStyle(.primary)
                    Text(item.label)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct PrimaryActionView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 12) {
            Button("Start Experience") {
                appState.selectedTab = .characters
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .frame(maxWidth: .infinity)
            
            Text("Takes about 3–5 minutes")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct ProgressSnapshotView: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: character.avatarName)
                .font(.title2)
                .foregroundStyle(.primary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                Text("Day in progress")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
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
