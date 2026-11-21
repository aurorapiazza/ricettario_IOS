import SwiftUI
import SwiftData

struct LoginView: View {
    @Binding var mostraRegistrazione: Bool
    @Binding var appenaRegistrato: Bool
    @Query var utenti: [Utente]
    @AppStorage("usernameLoggato") private var usernameLoggato = ""

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var mostraErrore: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer().frame(height: 20)

            VStack(spacing: 8) {
                Text("Bentornato!")
                    .font(.largeTitle)
                    .bold()
                Text("Accedi per le tue ricette preferite")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }

            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.system(size: 16, weight: .bold))

                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        TextField("Username", text: $username)
                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.system(size: 16, weight: .bold))

                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 24)

            if appenaRegistrato {
                Text("Account creato! Ora accedi con i tuoi dati.")
                    .foregroundColor(.green)
            }

            if mostraErrore {
                Text("Username o password non sono corretti.")
                    .foregroundColor(.red)
            }

            Button(action: {
                accedi()
            }) {
                Text("Accedi")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(coloreApp)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)

            Spacer()

            HStack(spacing: 5) {
                Text("Non hai un account?")
                    .font(.system(size: 14))
                Button(action: {
                    appenaRegistrato = false
                    mostraRegistrazione = true
                }) {
                    Text("Registrati")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(coloreApp)
                }
            }
            .padding(.bottom, 20)
        }
    }

    func accedi() {
        appenaRegistrato = false
        for utente in utenti {
            if utente.username == username && utente.password == password {
                usernameLoggato = utente.username
                return
            }
        }
        mostraErrore = true
    }
}