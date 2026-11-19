import SwiftUI

struct InfoRicetta: View {
    var recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            NavigationLink(destination: DettaglioRicettaView(recipe: recipe)) {
                HStack(spacing: 12) {
                    AsyncImage(
                        url: URL(string: recipe.image ?? ""),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            Color.gray.opacity(0.1)
                        })
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.1))
                    .mask(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text("\(recipe.readyInMinutes ?? 0) min")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
            }

            BottonePreferito(recipe: recipe, dimensione: 24)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
