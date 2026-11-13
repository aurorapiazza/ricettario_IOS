
import SwiftUI

struct ModalitaCucinaView: View {
    let nomeRicetta: String
    let passaggi: [RecipeStep]
    let ingredienti: [RecipeDetail.Ingredient]
    let tempoTotale: Int
    
    @State private var passaggioCorrente = 0
    
    func etichetta(_ ingrediente: RecipeIngredient) -> String {
        for completo in ingredienti {
            if completo.id == ingrediente.id {
                if let metrico = completo.measures?.metric {
                    return "\(ingrediente.name) \(metrico.amount.formatted()) \(metrico.unitShort)"
                }
            }
        }
        return ingrediente.name
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            VStack(spacing: 2) {
                Text(nomeRicetta)
                    .font(.system(size: 16, weight: .bold))
                Text("Modalità cucina")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            
            if passaggi.isEmpty {
                Spacer()
                Text("Nessun passaggio trovato.")
                    .frame(maxWidth: .infinity)
                Spacer()
            } else {
                let stepAttuale = passaggi[passaggioCorrente]
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        ForEach(0..<passaggi.count, id: \.self) {
                            index in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(index <= passaggioCorrente ? Color.black : Color.gray.opacity(0.2))
                                .frame(height: 4)
                        }
                    }
                    
                    Text("PASSAGGIO \(passaggioCorrente + 1) DI \(passaggi.count)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Passaggio \(stepAttuale.number)")
                            .font(.system(size: 32, weight: .bold))
                        Text(stepAttuale.step)
                            .font(.system(size: 20))
                        
                        HStack(spacing: 8) {
                            Image(systemName: "clock")
                            if let durata = stepAttuale.length {
                                Text("Passaggio \(durata.number) \(durata.unit)")
                                    .font(.system(size: 14, weight: .bold))
                            } else {
                                Text("Tempo totale \(tempoTotale) min")
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .overlay(Capsule()
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1))
                        
                        if !stepAttuale.ingredients.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Ingredienti per questo passaggio")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.gray)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(0..<stepAttuale.ingredients.count, id: \.self) {
                                            indice in Text(etichetta(stepAttuale.ingredients[indice]))
                                                .font(.system(size: 14))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .overlay(Capsule().stroke( Color.gray.opacity(0.4), lineWidth: 1))
                                        }
                                    }
                                    .padding(1)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                }
                
                HStack {
                    Button(action: {
                        if passaggioCorrente > 0 {
                            passaggioCorrente = passaggioCorrente - 1
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(passaggioCorrente == 0 ? .gray : .black)
                            .padding(16)
                            .overlay(Circle()
                                .stroke(passaggioCorrente == 0 ? Color.gray : Color.black, lineWidth: 1))
                    }
                    .disabled(passaggioCorrente == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if passaggioCorrente < passaggi.count - 1 {
                            passaggioCorrente = passaggioCorrente + 1
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(passaggioCorrente == passaggi.count - 1 ? .gray : .black)
                            .padding(16)
                            .overlay(Circle()
                                .stroke(passaggioCorrente == passaggi.count - 1 ? Color.gray : Color.black, lineWidth: 1))
                    }
                    .disabled(passaggioCorrente == passaggi.count - 1)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}
