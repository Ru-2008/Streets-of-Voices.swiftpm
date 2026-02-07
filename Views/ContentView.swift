import SwiftUI

struct ContentView: View {
    @ObservedObject var appState: AppState

    private var showOnboardingBinding: Binding<Bool> {
        Binding(
            get: { appState.showOnboarding },
            set: { appState.showOnboarding = $0 }
        )
    }

    var body: some View {
        if appState.hasStarted {
            MainTabView(appState: appState)
                .fullScreenCover(isPresented: showOnboardingBinding) {
                    OnboardingCarouselView()
                        .environmentObject(appState)
                }
        } else {
            OnboardingView(appState: appState)
        }
    }
}
