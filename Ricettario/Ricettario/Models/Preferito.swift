
import SwiftData

@Model
class Preferito {
    var usernameUtente: String
    var ricettaId: Int
    var titolo: String
    var immagine: String?
    var minuti: Int?
    var attivo: Bool

    init(usernameUtente: String, ricettaId: Int, titolo: String, immagine: String?, minuti: Int?) {
        self.usernameUtente = usernameUtente
        self.ricettaId = ricettaId
        self.titolo = titolo
        self.immagine = immagine
        self.minuti = minuti
        self.attivo = true
    }

    var recipe: Recipe {
        return Recipe(id: ricettaId, title: titolo, image: immagine, readyInMinutes: minuti)
    }
}
