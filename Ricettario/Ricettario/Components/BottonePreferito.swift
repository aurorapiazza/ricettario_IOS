
import SwiftUI
import SwiftData

struct BottonePreferito: View {
    var recipe: Recipe
    var dimensione: CGFloat = 20
    
    @Query var preferiti: [Preferito]
    @AppStorage("usernameLoggato") private var usernameLoggato = ""
    
    var preferitoSalvato: Preferito? {
        for preferito in preferiti {
            if preferito.usernameUtente == usernameLoggato && preferito.ricettaId == recipe.id {
                return preferito
            }
        }
        return nil
    }
    
    var isPreferito: Bool {
        if let preferito = preferitoSalvato {
            return preferito.attivo
        }
        return false
    }
    
    var body: some View {
        Button(action: {
            
        }) {
            Image(systemName: isPreferito ? "heart.fill" : "heart")
                .font(.system(size: dimensione))
                .foregroundColor(isPreferito ? Color.red : Color.primary)
        }
    }
}
