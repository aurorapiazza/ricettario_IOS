
import SwiftUI

struct ModalitaCucinaView: View {
    let nomeRicetta: String
    let passaggi: [RecipeStep]
    let ingredienti: [RecipeDetail.Ingredient]
    let tempoTotale: Int
    
    @State private var passaggioCorrente = 0
    
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
