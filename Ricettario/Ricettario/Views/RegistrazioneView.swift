import SwiftUI
import SwiftData

struct RegistrazioneView: View {
    @Binding var mostraRegistrazione: Bool
    @Environment(\.modelContext) private var context
    @Query var utenti: [Utente]

    @State private var nome = ""
    @State private var cognome = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordSecured = true
    @State private var messaggioErrore = ""

    var isEmailValid: Bool {
        for carattere in email {
            if carattere == "@" {
                return true
            }
        }
        return false
    }

    var isPasswordValid: Bool {
        var haMaiuscola = false
        var haNumero = false

        for carattere in password {
            if carattere >= "A" && carattere <= "Z" {
                haMaiuscola = true
            }
            if carattere >= "0" && carattere <= "9" {
                haNumero = true
            }
        }

        return password.count >= 8 && haMaiuscola && haNumero
    }

    let maiuscole = ["A","B", "C","D","E","F","G","H","I","J","K","L","M","N",
                     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    let minuscole = ["a","b", "c","d","e","f","g","h","i","j","k","l","m","n",
                     "n","o","p","q","r","s","t","u","v","w","x","y","z"]

    func inMinuscolo(_testo: String) -> String {
        var risultato = ""
        for carattere in testo{
            var nuovo = "\(carattere)"
            for indice in 0..<maiuscole.count{
                if nuovo == maiuscole[indice]{
                    nuovo = minuscole[indice]
                }
             }
             risultato = risultato + nuovo
        }
        return risultato
    }

    var isFormValid: Bool {
        return !nome.isEmpty && !cognome.isEmpty && !username.isEmpty && isEmailValid && isPasswordValid
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Crea il tuo account").font(.largeTitle).bold()
            Text("Registrati per salvare e cucinare le tue ricette").foregroundColor(.gray)

            HStack(spacing: 8) {
                VStack(alignment: .leading) {
                    Text("Nome").font(.headline)
                    HStack { TextField("Nome", text: $nome) }
                        .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                }
                VStack(alignment: .leading) {
                    Text("Cognome").font(.headline)
                    HStack { TextField("Cognome", text: $cognome) }
                        .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                }
            }

            Text("Username")
            HStack {
                Image(systemName: "person")
                TextField("username", text: $username)
            }
            .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4), lineWidth: 1))

            Text("Email")
            HStack {
                Image(systemName: "envelope").foregroundColor(.gray).font(.headline)
                TextField("email", text: $email)
            }
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(email.isEmpty || isEmailValid ? Color.gray.opacity(0.4) : Color.red, lineWidth: 1))

            Text("Password")
            HStack {
                if isPasswordSecured {
                    SecureField("password", text: $password)
                } else {
                    TextField("password", text: $password)
                }
                Button(action: {
                    isPasswordSecured.toggle()
                }) {
                    Image(systemName: isPasswordSecured ? "eye.slash" : "eye").foregroundColor(.gray)
                }
            }
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(password.isEmpty || isPasswordValid ? Color.gray.opacity(0.4) : Color.red, lineWidth: 1))
            Text("Almeno 8 caratteri con una lettera maiuscola e un numero").font(.caption).foregroundColor(.gray)

            if !messaggioErrore.isEmpty {
                Text(messaggioErrore).foregroundColor(.red)
            }

            Button(action: {
                registra()
            }) {
                Text("Registrati")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? coloreApp : Color.gray.opacity(0.4))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(!isFormValid)

            Spacer()

            HStack {
                Spacer()
                Text("Hai già un account?")
                Button(action: {
                    mostraRegistrazione = false
                }) {
                    Text("Accedi").bold().foregroundColor(coloreApp)
                }
                Spacer()
            }
        }
        .padding()
    }

    func registra() {
        let emailMinuscola = inMinuscolo(email)

        for utente in utenti {
            if utente.username == username {
                messaggioErrore = "Questo username è già in uso."
                return
            }
            if utente.email == emailMinuscola {
                messaggioErrore = "Questa email è già registrata."
                return
            }
        }

        let nuovoUtente = Utente(
            nome: nome,
            cognome: cognome,
            username: username,
            email: email,
            password: password
        )

        context.insert(nuovoUtente)
        try? context.save()

        mostraRegistrazione = false
    }
}
