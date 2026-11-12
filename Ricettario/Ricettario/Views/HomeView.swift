import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var api = Api()
    @State private var recipes = [Recipe]()
    @Query var utenti: [Utente]
    @AppStorage("usernameLoggato") private var usernameLoggato = ""

    var userName: String {
        for utente in utenti {
            if utente.username == usernameLoggato {
                return utente.nome
            }
        }
        return ""
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(userName.isEmpty ? "Buongiorno" : "Buongiorno, \(userName)")
                    .font(.largeTitle)
                    .foregroundColor(.gray)

                Text("Tutte le ricette")
                    .font(.title2)
                    .bold()

                ForEach(recipes) { recipe in
                    RecipeCard(recipe: recipe)
                }

            }
            .padding()
        }
        .onAppear {
            if recipes.isEmpty {
                api.loadRecipesData { (recipes) in
                    self.recipes = recipes
                }
            }
        }
    }
}

