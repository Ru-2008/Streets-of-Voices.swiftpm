import SwiftUI

@main
struct MyApp: App {

    @StateObject private var appState = AppState()

    var body: some SwiftUI.Scene {
        WindowGroup {
            if !appState.hasSeenOnboarding {
                OnboardingCarouselView()
                    .environmentObject(appState)
            } else {
                MainTabView(appState: appState)
                    .environmentObject(appState)
            }
        }
    }
}
