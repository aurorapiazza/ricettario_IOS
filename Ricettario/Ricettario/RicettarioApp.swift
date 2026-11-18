import SwiftUI
import SwiftData

let coloreApp = Color.orange

@main
struct RicettarioApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Utente.self, Preferito.self])
    }
}
