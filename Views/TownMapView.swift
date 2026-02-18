import SwiftUI

@MainActor
struct TownMapView: View {
    @ObservedObject var appState: AppState
    @State private var sceneLocation: Location?
    @State private var inaccessibleLocation: Location?

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 16) {
                ForEach(Location.all) { location in
                    LocationButton(location: location) {
                        tryOpenLocation(location)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .sheet(item: $sceneLocation) { location in
            LocationSceneView(location: location, appState: appState)
                .presentationDetents([.medium, .large])
        }
        .sheet(item: $inaccessibleLocation) { loc in
            InaccessibleMessageView(
                location: loc,
                characterName: appState.selectedCharacter?.name ?? "",
                onDismiss: { inaccessibleLocation = nil }
            )
        }
        .fullScreenCover(isPresented: $appState.showScanner) {
            if let locationID = appState.scannedLocationID,
               let location = Location.all.first(where: { $0.id == locationID }) {
                ScannerView(location: location)
                    .environmentObject(appState)
            }
        }
    }

    private func tryOpenLocation(_ location: Location) {
        guard let character = appState.selectedCharacter else {
            inaccessibleLocation = location
            return
        }
        if location.isAccessible(by: character) {
            appState.scannedLocationID = location.id
            appState.showScanner = true
        } else {
            inaccessibleLocation = location
        }
    }
}

struct LocationButton: View {
    let location: Location
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: location.symbol)
                    .font(.system(size: 36))
                    .foregroundStyle(.tint)
                Text(location.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
        .buttonStyle(.plain)
    }
}

struct LocationSceneView: View {
    let location: Location
    @ObservedObject var appState: AppState
    @State private var currentSceneID: String?
    @Environment(\.dismiss) private var dismiss
    
    init(location: Location, appState: AppState) {
        self.location = location
        self.appState = appState
        _currentSceneID = State(initialValue: location.startSceneID)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if location.startSceneID != nil {
                    if currentSceneID != nil {
                        SceneView(sceneID: $currentSceneID, appState: appState)
                    } else {
                        sceneEndedContent
                    }
                } else {
                    locationPlaceholderContent
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(location.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { 
                        appState.scannedLocationID = nil
                        dismiss() 
                    }
                }
            }
        }
    }

    private var sceneEndedContent: some View {
        VStack(spacing: 16) {
            Image(systemName: location.symbol)
                .font(.system(size: 48))
                .foregroundStyle(.tint)
            Text("You're done here.")
                .font(.title3)
            Text("Close when you're ready.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var locationPlaceholderContent: some View {
        VStack(spacing: 16) {
            Image(systemName: location.symbol)
                .font(.system(size: 48))
                .foregroundStyle(.tint)
            Text(location.name)
                .font(.title2)
            Text("You're here. More to explore.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

struct InaccessibleMessageView: View {
    let location: Location
    let characterName: String
    let onDismiss: () -> Void

    private var message: String {
        if characterName.isEmpty {
            return "Choose a character first so we know who's exploring. Head to the Characters tab to pick someone."
        }
        return "This place isn't right for \(characterName) right now. That's okay — other spots might feel more welcoming."
    }

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart.slash")
                .font(.system(size: 44))
                .foregroundStyle(.secondary)

            Text(message)
                .font(.body)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("OK", action: onDismiss)
                .buttonStyle(.borderedProminent)
        }
        .padding(32)
        .presentationDetents([.height(220)])
    }
}
