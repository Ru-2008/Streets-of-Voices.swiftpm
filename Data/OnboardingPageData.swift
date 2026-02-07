import SwiftUI

struct OnboardingPage: Identifiable {
    let id: Int
    let icon: String
    let title: String
    let subtitle: String
    let accentColor: Color

    static let pages: [OnboardingPage] = [
        OnboardingPage(
            id: 0,
            icon: "brain.head.profile",
            title: "Understand Different Lives",
            subtitle: "Experience how the same town feels different for different people.",
            accentColor: .blue
        ),
        OnboardingPage(
            id: 1,
            icon: "map",
            title: "See the Same Town",
            subtitle: "Places don't change — perspectives do.",
            accentColor: .green
        ),
        OnboardingPage(
            id: 2,
            icon: "figure.walk",
            title: "Begin Your Journey",
            subtitle: "Small choices reveal big differences in daily life.",
            accentColor: .pink
        )
    ]
}
