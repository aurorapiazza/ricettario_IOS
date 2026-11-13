import SwiftUI
import SwiftData

struct PreferitiView: View {
    @Query var preferiti: [Preferito]
    @AppStorage("usernameLoggato") private var usernameLoggato = ""

    var preferitiUtente: [Preferito] {
        var risultato = [Preferito]()
        for preferito in preferiti {
            if preferito.usernameUtente == usernameLoggato && preferito.attivo {
                risultato.append(preferito)
            }
        }
        return risultato
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Ricette Preferite")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)

                if preferitiUtente.isEmpty {
                    Text("Non hai ancora ricette preferite.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }

                ForEach(preferitiUtente) { preferito in
                    InfoRicetta(recipe: preferito.recipe)
                }
            }
            .padding()
        }
    }
}
