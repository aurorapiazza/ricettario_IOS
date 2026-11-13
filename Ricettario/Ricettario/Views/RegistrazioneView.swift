import SwiftUI

struct RegistrazioneView: View {
    @Binding var mostraRegistrazione: Bool
    @State private var nome = ""
    @State private var cognome = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordSecured = true
    
    
    
    var isEmailValid: Bool{
        for carattere in email{
            if carattere == "@"{
                return true
            }
        }
        return false
    }
    
    var isPasswordValid: Bool{
        var haMaiuscolo = false
        var haNumero = false
        
        for carattere in password{
            if carattere >= "A" && carattere <= "Z"{
                haMaiuscolo = true
            }
            if carattere >= "0" && carattere <= "9"{
                haNumero = true
            }
        }
        return password.count >= 8 && haNumero && haMaiuscolo
    }
    
    var isFormValid: Bool{
        return !nome.isEmpty && !cognome.isEmpty && !username.isEmpty && isEmailValid
    }

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
            
            Text("Username")
            HStack{
                Image(systemName: "person")
                TextField("username", text: $username)
            }.padding(10)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
            
            Text("Email")
            HStack{
                Image(systemName: "envelop").foregroundColor(.gray).font(.headline)
                TextField("email", text: $email)
            }.padding(10)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke( email.isEmpty ?  Color.black : Color.red, lineWidth: 1))
            
            Text("Password")
            HStack{
                if isPasswordSecured{
                    SecureField("password", text: $password)
                }else{
                    TextField("password", text: $password)
                }
                Button(action: {
                    isPasswordSecured.toggle()
                }){
                    Image(systemName: isPasswordSecured ? "eye.slash" : "eye").foregroundColor(.gray)
                }
            }.padding(10)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1))
            Text("Almeno 8 caratteri con una lettera maiuscola e un numero").font(.caption).foregroundColor(.gray)

            Button(action:{
                
            }){
                Text("Registrati").bold().frame(maxWidth: .infinity).padding().background(Color.black).foregroundColor(.white).cornerRadius(12)
            }
            
            Spacer()
            
            HStack{
                Spacer()
                Text("Hai già un account?")
                Button(action: {
                    mostraRegistrazione = false
                }){
                    Text("Accedi").bold().foregroundColor(.black)
                }
                Spacer()
            }
            
        }
        .padding()
    }
}
