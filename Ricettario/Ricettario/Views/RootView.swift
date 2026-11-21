import SwiftUI

struct RootView: View {
    @AppStorage("usernameLoggato") private var usernameLoggato = ""
    @State private var mostraRegistrazione = false
    @State private var appenaRegistrato = false

    var body: some View {
        if usernameLoggato != "" {
            MainTabView()
        } else if mostraRegistrazione {
            RegistrazioneView(mostraRegistrazione: $mostraRegistrazione, appenaRegistrato: $appenaRegistrato)
        } else {
            LoginView(mostraRegistrazione: $mostraRegistrazione, appenaRegistrato: $appenaRegistrato)
        }
    }
}