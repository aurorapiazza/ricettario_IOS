import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var api = Api()
    @State private var recipes = [Recipe]()
    @State private var erroreCaricamento = false
    @State private var inCaricamento = false
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

    var rowCount: Int {
        return (recipes.count + 1) / 2
    }

    func caricaRicette(offset: Int) {
        erroreCaricamento = false
        inCaricamento = true
        api.loadRecipesData(offset: offset) { (nuoveRicette) in
            self.inCaricamento = false
            if let nuoveRicette = nuoveRicette {
                if offset == 0 {
                    self.recipes = nuoveRicette
                } else {
                    for ricetta in nuoveRicette {
                        self.recipes.append(ricetta)
                    }
                }
            } else {
                self.erroreCaricamento = true
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(userName.isEmpty ? "Buongiorno" : "Buongiorno, \(userName)")
                    .font(.largeTitle)
                    .bold()

                if erroreCaricamento {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Non è stato possibile caricare le ricette. Controlla la connessione: se il problema resta, la quota giornaliera di Spoonacular potrebbe essere finita.")
                            .foregroundColor(.red)
                        Button(action: {
                            caricaRicette(offset: recipes.count)
                        }) {
                            Text("Riprova")
                                .bold()
                                .foregroundColor(coloreApp)
                        }
                    }
                }

                if let featured = api.featuredRecipe {
                    FeaturedRecipeCard(
                        recipe: featured,
                        onRefresh: {
                            api.loadRandomRecipe()
                        }
                    )
                }

                Text("Tutte le ricette")
                    .font(.title2)
                    .bold()

                VStack(spacing: 14) {
                    ForEach(0..<rowCount, id: \.self) { row in
                        HStack(spacing: 14) {
                            RecipeCard(recipe: recipes[row * 2])
                                .frame(maxWidth: .infinity)

                            if row * 2 + 1 < recipes.count {
                                RecipeCard(recipe: recipes[row * 2 + 1])
                                    .frame(maxWidth: .infinity)
                            } else {
                                Spacer()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }

                if !recipes.isEmpty {
                    Button(action: {
                        caricaRicette(offset: recipes.count)
                    }) {
                        Text(inCaricamento ? "Caricamento..." : "Mostra altre ricette")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(coloreApp)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(coloreApp, lineWidth: 1)
                            )
                    }
                    .disabled(inCaricamento)
                }
            }
            .padding()
        }
        .onAppear {
            if recipes.isEmpty {
                caricaRicette(offset: 0)
            }
            if api.featuredRecipe == nil {
                api.loadRandomRecipe()
            }
        }
    }
}