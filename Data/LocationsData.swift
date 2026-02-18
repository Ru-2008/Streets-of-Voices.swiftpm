import Foundation
import CoreGraphics

@MainActor
final class LocationsData {
    static let shared = LocationsData()
    
    let locations: [Location] = [
        // Core locations
        Location(
            id: "home",
            name: "Home",
            symbol: "house.fill",
            description: "Where the day begins and ends",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.2, y: 0.8)
        ),
        Location(
            id: "school",
            name: "School",
            symbol: "building.columns.fill",
            description: "Place of learning and growth",
            accessibleByCharacterIds: ["aarav", "kavya"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.4, y: 0.3)
        ),
        Location(
            id: "market",
            name: "Market",
            symbol: "cart.fill",
            description: "Local shopping and community hub",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.7, y: 0.4)
        ),
        Location(
            id: "bus-stop",
            name: "Bus Stop",
            symbol: "bus.fill",
            description: "Public transportation hub",
            accessibleByCharacterIds: ["imran", "nirmala"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.1, y: 0.5)
        ),
        Location(
            id: "clinic",
            name: "Clinic",
            symbol: "cross.fill",
            description: "Healthcare and wellness center",
            accessibleByCharacterIds: ["savita"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.8, y: 0.7)
        ),
        
        // Demo locations
        Location(
            id: "library",
            name: "Library",
            symbol: "books.vertical.fill",
            description: "Quiet space for reading and study",
            accessibleByCharacterIds: ["aarav", "rohan", "kavya"],
            startSceneID: "library-intro",
            mapPosition: CGPoint(x: 0.3, y: 0.2)
        ),
        Location(
            id: "park",
            name: "Park",
            symbol: "leaf.fill",
            description: "Green space for relaxation",
            accessibleByCharacterIds: ["rohan", "savita", "imran"],
            startSceneID: "park-intro",
            mapPosition: CGPoint(x: 0.6, y: 0.1)
        ),
        Location(
            id: "cafe",
            name: "Café",
            symbol: "cup.and.saucer.fill",
            description: "Cozy spot for coffee and conversation",
            accessibleByCharacterIds: ["aarav", "meena", "savita", "kavya"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.5, y: 0.6)
        ),
        Location(
            id: "town-square",
            name: "Town Square",
            symbol: "building.columns.fill",
            description: "Heart of the community",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.4, y: 0.5)
        ),
        
        // Additional locations to make town feel alive
        Location(
            id: "factory",
            name: "Factory",
            symbol: "gearshape.fill",
            description: "Industrial workplace",
            accessibleByCharacterIds: ["imran"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.1, y: 0.2)
        ),
        Location(
            id: "playground",
            name: "Playground",
            symbol: "figure.play",
            description: "Fun space for children",
            accessibleByCharacterIds: ["aarav", "kavya"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.2, y: 0.4)
        ),
        Location(
            id: "grocery",
            name: "Grocery Store",
            symbol: "cart.fill",
            description: "Daily essentials shopping",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.8, y: 0.3)
        ),
        Location(
            id: "pharmacy",
            name: "Pharmacy",
            symbol: "cross.fill",
            description: "Medicine and health supplies",
            accessibleByCharacterIds: ["savita"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.7, y: 0.8)
        ),
        Location(
            id: "community-center",
            name: "Community Center",
            symbol: "person.2.fill",
            description: "Gathering place for events",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.3, y: 0.7)
        ),
        Location(
            id: "post-office",
            name: "Post Office",
            symbol: "envelope.fill",
            description: "Mail and package services",
            accessibleByCharacterIds: [],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.6, y: 0.9)
        ),
        Location(
            id: "train-station",
            name: "Train Station",
            symbol: "tram.fill",
            description: "Rail transportation hub",
            accessibleByCharacterIds: ["imran", "nirmala"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.9, y: 0.5)
        ),
        Location(
            id: "office-building",
            name: "Office Building",
            symbol: "building.2.fill",
            description: "Professional workspace",
            accessibleByCharacterIds: ["kavya", "nirmala"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.5, y: 0.3)
        ),
        Location(
            id: "gym",
            name: "Gym",
            symbol: "dumbbell.fill",
            description: "Fitness and exercise facility",
            accessibleByCharacterIds: ["imran"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.1, y: 0.7)
        ),
        Location(
            id: "bookstore",
            name: "Bookstore",
            symbol: "books.vertical.fill",
            description: "Books and reading materials",
            accessibleByCharacterIds: ["aarav", "kavya"],
            startSceneID: nil,
            mapPosition: CGPoint(x: 0.9, y: 0.2)
        )
    ]
    
    private init() {}
}