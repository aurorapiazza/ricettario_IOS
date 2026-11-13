import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: DettaglioRicettaView(recipe: recipe)) {
            VStack(alignment: .leading, spacing: 8) {
            AsyncImage(
                url: URL(string: recipe.image ?? ""),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }, placeholder: {
                    Color.gray.opacity(0.2)
                })
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .mask(RoundedRectangle(cornerRadius: 10))

            HStack {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(height: 44)
            }
            }
            
            HStack {
                Text("\(recipe.readyInMinutes ?? 0) min")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                BottonePreferito(recipe: recipe)
            }
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
        )
    }
}

