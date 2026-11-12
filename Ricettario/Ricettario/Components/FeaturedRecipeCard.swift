import SwiftUI

struct FeaturedRecipeCard: View {
    var recipe: Recipe
    var onRefresh: () -> ()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                NavigationLink(destination: DettaglioRicettaView(recipe: recipe)) {
                AsyncImage(
                    url: URL(string: recipe.image ?? ""),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }, placeholder: {
                        Color.gray.opacity(0.2)
                    })
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .mask(RoundedRectangle(cornerRadius: 14))
                }

                HStack {
                    Text("Ricetta consigliata")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange)
                        .cornerRadius(20)

                    Spacer()

                    Button(action: onRefresh) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.white.opacity(0.85))
                            .cornerRadius(20)
                    }
                }
                .padding(10)

            }

            NavigationLink(destination: DettaglioRicettaView(recipe: recipe)) {
                Text(recipe.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
            }

            HStack {
                Text("\(recipe.readyInMinutes ?? 0) min")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                BottonePreferito(recipe: recipe)
            }
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
        )
    }
}

