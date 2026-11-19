import SwiftUI

struct DettaglioRicettaView: View {
   
    var recipe: Recipe

    @StateObject private var api = Api()
    @State private var dettaglio: RecipeDetail?
    @State private var errore = false
    @State private var porzioni: Double = 4
    @State private var spuntati = [Bool]()

    var ingredienti: [Ingredient] {
        return dettaglio?.extendedIngredients ?? []
    }

    var passaggi: [RecipeStep] {
        if let istruzioni = dettaglio?.analyzedInstructions {
            if let primoGruppo = istruzioni.first {
                return primoGruppo.steps
            }
        }
        return []
    }

    func quantita(_ ingrediente: Ingredient) -> String {
        let porzioniOriginali = dettaglio?.servings ?? porzioni
        var valore = ingrediente.amount
        var unita = ingrediente.unit

        if let metrico = ingrediente.measures?.metric {
            valore = metrico.amount
            unita = metrico.unitShort
        }

        valore = valore * porzioni / porzioniOriginali
        return "\(valore.formatted()) \(unita)"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottom) {
                    AsyncImage(
                        url: URL(string: recipe.image ?? ""),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            Color.gray.opacity(0.1)
                        })
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))

                    HStack {
                        Text("\(recipe.readyInMinutes ?? 0) min")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .overlay(Capsule().stroke(Color.gray.opacity(0.4), lineWidth: 1))
                        Text("\(porzioni.formatted()) porz.")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .overlay(Capsule().stroke(Color.gray.opacity(0.4), lineWidth: 1))
                        Spacer()
                    }
                    .padding(10)
                }

                HStack {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    BottonePreferito(recipe: recipe, dimensione: 28)
                }

                if errore {
                    Text("Non è stato possibile caricare la ricetta. Controlla la connessione: se il problema resta, la quota giornaliera di Spoonacular potrebbe essere finita.")
                        .foregroundColor(.red)
                } else if dettaglio == nil {
                    Text("Caricamento della ricetta...")
                        .foregroundColor(.gray)
                }

                Text("Ingredienti")
                    .font(.title2)
                    .bold()

                Stepper("Porzioni: \(porzioni.formatted())", value: $porzioni, in: 1...12)

                ForEach(0..<ingredienti.count, id: \.self) { indice in
                    HStack {
                        Button(action: {
                            spuntati[indice].toggle()
                        }) {
                            Image(systemName: spuntati[indice] ? "checkmark.square" : "square")
                                .font(.system(size: 22))
                                .foregroundColor(spuntati[indice] ? coloreApp : .gray)
                        }
                        Text(ingredienti[indice].name)
                        Spacer()
                        Text(quantita(ingredienti[indice]))
                            .foregroundColor(.gray)
                    }
                    Divider()
                }

                Text("Preparazione")
                    .font(.title2)
                    .bold()

                if dettaglio != nil && passaggi.isEmpty {
                    Text("Questa ricetta non ha passaggi.")
                        .foregroundColor(.gray)
                }

                ForEach(0..<passaggi.count, id: \.self) { indice in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(passaggi[indice].number)")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(coloreApp)
                            .cornerRadius(18)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(passaggi[indice].step)
                            if let durata = passaggi[indice].length {
                                Text("\(durata.number) \(durata.unit)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                NavigationLink(destination: ModalitaCucinaView(
                    nomeRicetta: recipe.title,
                    passaggi: passaggi,
                    ingredienti: ingredienti,
                    tempoTotale: recipe.readyInMinutes ?? 0
                )) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Avvia Modalità Cucina").bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(passaggi.isEmpty ? Color.gray.opacity(0.4) : coloreApp)
                    .cornerRadius(12)
                }
                .disabled(passaggi.isEmpty)
            }
            .padding()
        }
        .onAppear {
            if dettaglio == nil {
                api.loadRecipeDetail(id: recipe.id) { (risposta) in
                    guard let ricetta = risposta else {
                        self.errore = true
                        return
                    }
                    self.dettaglio = ricetta
                    self.porzioni = ricetta.servings ?? 4

                    // Una spunta per ogni ingrediente, tutte vuote
                    var nuoveSpunte = [Bool]()
                    for _ in ricetta.extendedIngredients ?? [] {
                        nuoveSpunte.append(false)
                    }
                    self.spuntati = nuoveSpunte
                }
            }
        }
    }
}

