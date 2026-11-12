import SwiftUI
import SwiftData

struct ProfiloView: View {
    @Query var utenti: [Utente]
    @AppStorage("usernameLoggato") private var usernameLoggato = ""

    var utente: Utente? {
        for persona in utenti {
            if persona.username == usernameLoggato {
                return persona
            }
        }
        return nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("@\(usernameLoggato)")
                .font(.largeTitle)
                .bold()

            Divider()

            HStack {
                Text("Nome").foregroundColor(.gray)
                Spacer()
                Text(utente?.nome ?? "").bold()
            }

            Divider()

            HStack {
                Text("Cognome").foregroundColor(.gray)
                Spacer()
                Text(utente?.cognome ?? "").bold()
            }

            Divider()

        }
        .padding()
    }
}
