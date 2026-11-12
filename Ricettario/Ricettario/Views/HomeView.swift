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

    var rowCount: Int {
        return (recipes.count + 1) / 2
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(userName.isEmpty ? "Buongiorno" : "Buongiorno, \(userName)")
                    .font(.largeTitle)
                    .foregroundColor(.gray)

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
            }
            .padding()
        }
        .onAppear {
            if recipes.isEmpty {
                api.loadRecipesData { (recipes) in
                    self.recipes = recipes
                }
            }
            if api.featuredRecipe == nil {
                api.loadRandomRecipe()
            }
        }
    }
}

