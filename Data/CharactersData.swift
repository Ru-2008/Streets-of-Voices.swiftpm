import Foundation

// Concurrency-safe character data provider
@MainActor
final class CharactersData {
    static let shared = CharactersData()
    
    let characters: [Character] = [
        Character(
            id: "aarav",
            name: "Aarav",
            role: "Student",
            age: 17,
            shortBio: "High school student balancing studies and part-time work.",
            mindset: "Always thinking about time, exams, and expectations.",
            dailyGoal: "Reach school on time without exhausting myself.",
            avatarName: "person.circle.fill",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "meena",
            name: "Meena",
            role: "Street Vendor",
            age: 34,
            shortBio: "Sells handmade crafts to support her family.",
            mindset: "Every hour matters because income is uncertain.",
            dailyGoal: "Earn enough today to cover food and rent.",
            avatarName: "person.crop.circle.fill",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "rohan",
            name: "Rohan",
            role: "Wheelchair User",
            age: 28,
            shortBio: "Software developer navigating accessibility challenges.",
            mindset: "Constantly planning routes to avoid barriers.",
            dailyGoal: "Move independently without needing help.",
            avatarName: "figure.roll",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "savita",
            name: "Savita",
            role: "Grandparent",
            age: 68,
            shortBio: "Retired teacher enjoying quiet walks in the neighborhood.",
            mindset: "Energy is limited; comfort and dignity come first.",
            dailyGoal: "Complete daily tasks without exhaustion.",
            avatarName: "person.fill.viewfinder",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        )
    ]
    
    let stories: [CharacterStory] = [
        CharacterStory(
            id: "aarav",
            worldviewDescription: "The town feels like a race against time. Every shortcut matters, every delay feels like failure. School bells echo urgency through the streets.",
            keyConcerns: ["time", "academic pressure", "energy management"],
            emotionalTone: "anxious"
        ),
        CharacterStory(
            id: "meena",
            worldviewDescription: "Every corner holds potential customers or empty spaces. The town's rhythm depends on foot traffic and weather. Success feels fragile and immediate.",
            keyConcerns: ["income", "weather", "customer flow"],
            emotionalTone: "determined"
        ),
        CharacterStory(
            id: "rohan",
            worldviewDescription: "The town reveals itself as a series of obstacles and solutions. Curbs become barriers, ramps become pathways. Independence requires constant vigilance and planning.",
            keyConcerns: ["accessibility", "independence", "physical barriers"],
            emotionalTone: "focused"
        ),
        CharacterStory(
            id: "savita",
            worldviewDescription: "The town moves at a gentle pace that matches aging joints. Familiar routes offer comfort, while new paths require careful consideration. Each step is intentional.",
            keyConcerns: ["comfort", "energy conservation", "familiarity"],
            emotionalTone: "peaceful"
        )
    ]
    
    private init() {}
}