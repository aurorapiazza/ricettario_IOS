import SwiftUI
import SwiftData

struct PreferitiView: View {
    @Query var preferiti: [Preferito]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Ricette Preferite")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)

                ForEach(preferiti) { preferito in
                    InfoRicetta(recipe: preferito.recipe)
                }
            }
            .padding()
        }
    }
}
