import SwiftUI

@main
struct MyApp: App {
    typealias Body = <#type#>
    
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState)
        }
    }
}
