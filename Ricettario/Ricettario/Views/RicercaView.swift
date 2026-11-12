import SwiftUI

let tipiAPI = ["", "main course", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast",
               "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]
let tipiNomi = ["Tutti", "Piatto principale", "Contorno", "Dolce", "Antipasto", "Insalata", "Pane", "Colazione",
                "Zuppa", "Bevanda", "Salsa", "Marinata", "Finger food", "Snack", "Drink"]

struct FiltriPag: View {
    @Binding var tipoScelto: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Tipo di piatto")
                Spacer()
                Picker("Tipo di piatto", selection: $tipoScelto) {
                    ForEach(0..<tipiNomi.count, id: \.self) { indice in
                        Text(tipiNomi[indice]).tag(indice)
                    }
                }
            }

            Divider()

            Text("Torna indietro: la ricerca si aggiorna da sola con i nuovi filtri.")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .accentColor(.black)
        .navigationTitle("Filtri")
    }
}
