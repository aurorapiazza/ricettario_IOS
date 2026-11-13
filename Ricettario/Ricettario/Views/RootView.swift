
import SwiftUI

struct RootView: View {
    @AppStorage("usernameLoggato") private var usernameLoggato = ""
    @State private var mostraRegistrazione = false
    
    var body: some View {
        if usernameLoggato != "" {
            MainTabView()
        } else if mostraRegistrazione {
            RegistrazioneView(mostraRegistrazione: $mostraRegistrazione)
        } else {
            LoginView(mostraRegistrazione: $mostraRegistrazione)
        }
    }
}
