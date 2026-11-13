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

struct RicercaView: View {
    @StateObject private var api = Api()
    @State private var cercaTesto = ""
    @State private var risultati = [Recipe]()
    @State private var totale = 0
    @State private var haCercato = false
    @State private var errore = false

    // Filtri: indici nelle liste qui sopra. tempoMax = 0 significa nessun limite.
    @State private var tipoScelto = 0
    @State private var dietaScelta = 0
    @State private var cucinaScelta = 0
    @State private var tempoMax = 0

    var filtriAttivi: Int {
        var numero = 0
        if tipoScelto != 0 { numero = numero + 1 }
        if dietaScelta != 0 { numero = numero + 1 }
        if cucinaScelta != 0 { numero = numero + 1 }
        if tempoMax != 0 { numero = numero + 1 }
        return numero
    }

    // Spoonacular accetta anche una ricerca senza testo, purché ci sia almeno un filtro
    var puoCercare: Bool {
        return cercaTesto != "" || filtriAttivi > 0
    }

    func eseguiRicerca() {
        if !puoCercare {
            return
        }

        errore = false

        api.searchRecipes(
            testo: cercaTesto,
            tipo: tipiAPI[tipoScelto],
            dieta: dieteAPI[dietaScelta],
            cucina: cucineAPI[cucinaScelta],
            tempoMax: tempoMax,
            ordinamento: "popularity",
            offset: 0
        ) { (risposta) in
            self.haCercato = true

            if let risposta = risposta {
                self.risultati = risposta.results
                self.totale = risposta.totalResults ?? self.risultati.count
            } else {
                self.errore = true
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Cerca in inglese, es. pasta", text: $cercaTesto)
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1.5)
                    )

                    NavigationLink(destination: FiltriPag(
                        tipoScelto: $tipoScelto,
                        dietaScelta: $dietaScelta,
                        cucinaScelta: $cucinaScelta,
                        tempoMax: $tempoMax
                    )) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 18))
                            .foregroundColor(filtriAttivi == 0 ? .gray : .black)
                            .frame(width: 44, height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(filtriAttivi == 0 ? Color.gray : Color.black, lineWidth: 1.5)
                            )
                    }

                    Button(action: {
                        eseguiRicerca()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18))
                            .foregroundColor(puoCercare ? .black : .gray)
                            .frame(width: 44, height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 1.5)
                            )
                    }
                    .disabled(!puoCercare)
                }

                if filtriAttivi > 0 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if tipoScelto != 0 {
                                EtichettaFiltro(testo: tipiNomi[tipoScelto])
                            }
                            if dietaScelta != 0 {
                                EtichettaFiltro(testo: dieteNomi[dietaScelta])
                            }
                            if cucinaScelta != 0 {
                                EtichettaFiltro(testo: "Cucina: " + cucineNomi[cucinaScelta])
                            }
                            if tempoMax != 0 {
                                EtichettaFiltro(testo: "Max \(tempoMax) min")
                            }
                        }
                        .padding(1)
                    }
                }

                if errore {
                    Text("Ricerca non riuscita. Controlla la connessione: se il problema resta, la quota giornaliera di Spoonacular potrebbe essere finita.")
                        .foregroundColor(.red)
                }

                if haCercato && !errore {
                    Text("\(totale) risultati")
                        .foregroundColor(.gray)
                }

                if haCercato && !errore && risultati.isEmpty {
                    Text("Nessuna ricetta trovata. Prova con una parola in inglese o con meno filtri.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }

                ForEach(risultati) { ricetta in
                    InfoRicetta(recipe: ricetta)
                }

            }
            .padding()
        }
    }
}

struct EtichettaFiltro: View {
    var testo: String

    var body: some View {
        Text(testo)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
    }
}

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
