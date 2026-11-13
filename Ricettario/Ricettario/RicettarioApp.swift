import SwiftUI
import SwiftData

@main
struct RicettarioApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Utente.self, Preferito.self])
    }
}
