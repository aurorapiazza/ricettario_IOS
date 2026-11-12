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

            Spacer()

            Button(action: {
                usernameLoggato = ""
            }) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Esci").bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 2)
                )
            }

        }
        .padding()
    }
}
