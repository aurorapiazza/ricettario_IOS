import SwiftUI

let tipiAPI = ["", "main course", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast",
               "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]
let tipiNomi = ["Tutti", "Piatto principale", "Contorno", "Dolce", "Antipasto", "Insalata", "Pane", "Colazione",
                "Zuppa", "Bevanda", "Salsa", "Marinata", "Finger food", "Snack", "Drink"]

let dieteAPI = ["", "vegetarian", "vegan", "gluten free", "ketogenic", "pescetarian", "paleo"]
let dieteNomi = ["Tutte", "Vegetariana", "Vegana", "Senza glutine", "Chetogenica", "Pescetariana", "Paleo"]

let cucineAPI = ["", "italian", "mediterranean", "french", "spanish", "greek", "american",
                 "mexican", "indian", "chinese", "japanese", "thai", "middle eastern"]
let cucineNomi = ["Tutte", "Italiana", "Mediterranea", "Francese", "Spagnola", "Greca", "Americana",
                  "Messicana", "Indiana", "Cinese", "Giapponese", "Thailandese", "Mediorientale"]

struct FiltriPag: View {
    @Binding var tipoScelto: Int
    @Binding var dietaScelta: Int
    @Binding var cucinaScelta: Int
    @Binding var tempoMax: Int

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

            HStack {
                Text("Dieta")
                Spacer()
                Picker("Dieta", selection: $dietaScelta) {
                    ForEach(0..<dieteNomi.count, id: \.self) { indice in
                        Text(dieteNomi[indice]).tag(indice)
                    }
                }
            }

            Divider()

            HStack {
                Text("Cucina")
                Spacer()
                Picker("Cucina", selection: $cucinaScelta) {
                    ForEach(0..<cucineNomi.count, id: \.self) { indice in
                        Text(cucineNomi[indice]).tag(indice)
                    }
                }
            }

            Divider()

            Stepper(tempoMax == 0 ? "Tempo massimo: nessun limite" : "Tempo massimo: \(tempoMax) min",
                    onIncrement: {
                        if tempoMax < 180 {
                            tempoMax = tempoMax + 15
                        }
                    }, onDecrement: {
                        if tempoMax > 0 {
                            tempoMax = tempoMax - 15
                        }
                    })

            Divider()

            Button(action: {
                tipoScelto = 0
                dietaScelta = 0
                cucinaScelta = 0
                tempoMax = 0
            }) {
                Text("Azzera filtri")
                    .foregroundColor(.red)
            }

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
