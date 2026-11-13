
import SwiftData

@Model
class Utente {
    var nome: String
    var cognome: String
    var username: String
    var email: String
    var password: String
    
    init(nome: String, cognome: String, username: String, email: String, password: String) {
        self.nome = nome
        self.cognome = cognome
        self.username = username
        self.email = email
        self.password = password
    }
    
}
