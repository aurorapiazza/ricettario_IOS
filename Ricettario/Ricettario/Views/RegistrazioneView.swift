import SwiftUI

struct RegistrazioneView: View {
    @State private var nome = ""
    @State private var cognome = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Crea il tuo account").font(.largeTitle).bold()
            Text("Registrati per salvare e cucinare le tue ricette").foregroundColor(.gray)

            HStack(spacing: 8) {
                VStack(alignment: .leading) {
                    Text("Nome").font(.headline)
                    HStack { TextField("Nome", text: $nome) }
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                VStack(alignment: .leading) {
                    Text("Cognome").font(.headline)
                    HStack { TextField("Cognome", text: $cognome) }
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
            }

        }
        .padding()
    }
}
