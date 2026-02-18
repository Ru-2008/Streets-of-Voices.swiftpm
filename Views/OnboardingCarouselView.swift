import SwiftUI

struct OnboardingCarouselView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage = 0

    private var isLastPage: Bool { currentPage == OnboardingPage.pages.count - 1 }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.pages) { page in
                    OnboardingPageView(page: page)
                        .tag(page.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))

            VStack(spacing: 24) {
                ctaButton
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
            }
        }
        .background(backgroundGradient)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.secondarySystemBackground).opacity(0.6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var ctaButton: some View {
        let page = OnboardingPage.pages[currentPage]
        return Button {
            if isLastPage {
                appState.completeOnboarding()
            } else {
                withAnimation {
                    currentPage += 1
                }
            }
        } label: {
            Text(isLastPage ? "Start Experience" : "Continue")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
        }
        .buttonStyle(.borderedProminent)
        .tint(page.accentColor)
        .controlSize(.large)
    }
}

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            iconSection
            textSection
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 40)
    }

    private var iconSection: some View {
        ZStack {
            Circle()
                .fill(page.accentColor.opacity(0.12))
                .frame(width: 200, height: 200)

            Circle()
                .fill(page.accentColor.opacity(0.25))
                .frame(width: 140, height: 140)

            Image(systemName: page.icon)
                .font(.system(size: 80))
                .foregroundStyle(page.accentColor)
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var textSection: some View {
        VStack(spacing: 12) {
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(page.subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
