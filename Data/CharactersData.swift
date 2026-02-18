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
            coreValues: ["time", "academic pressure", "energy management"],
            dailyGoal: "Reach school on time without exhausting myself.",
            emotionalBaseline: "anxious",
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
            coreValues: ["income", "weather", "customer flow"],
            dailyGoal: "Earn enough today to cover food and rent.",
            emotionalBaseline: "determined",
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
            coreValues: ["accessibility", "independence", "physical barriers"],
            dailyGoal: "Move independently without needing help.",
            emotionalBaseline: "focused",
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
            coreValues: ["comfort", "energy conservation", "familiarity"],
            dailyGoal: "Complete daily tasks without exhaustion.",
            emotionalBaseline: "peaceful",
            avatarName: "person.fill.viewfinder",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "kavya",
            name: "Kavya",
            role: "Working Mother",
            age: 35,
            shortBio: "Balancing career and family responsibilities.",
            mindset: "Always balancing time between work and family.",
            coreValues: ["time", "family", "work-life balance"],
            dailyGoal: "Get through the day without letting anyone down.",
            emotionalBaseline: "stressed",
            avatarName: "person.3.fill",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "imran",
            name: "Imran",
            role: "Delivery Rider",
            age: 29,
            shortBio: "Making deliveries across the city to earn a living.",
            mindset: "Speed means income, but safety is always at risk.",
            coreValues: ["speed", "safety", "income"],
            dailyGoal: "Complete enough deliveries without exhaustion.",
            emotionalBaseline: "tense",
            avatarName: "figure.walk.motion",
            baseStats: Stats(visits: 0, conversations: 0, discoveries: 0)
        ),
        Character(
            id: "nirmala",
            name: "Nirmala",
            role: "Small Shop Owner",
            age: 52,
            shortBio: "Running a small local shop serving the community.",
            mindset: "Every customer matters; every loss hurts.",
            coreValues: ["customers", "profit", "community"],
            dailyGoal: "Keep the shop running despite rising costs.",
            emotionalBaseline: "worried",
            avatarName: "cart.fill",
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