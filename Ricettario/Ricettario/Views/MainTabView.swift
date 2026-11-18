import SwiftUI

struct MainTabView: View {
    @State private var tabScelta = 0

    var body: some View {
        VStack(spacing: 0){
            ZStack {
                NavigationStack {
                    HomeView()
                }
                .opacity(tabScelta == 0 ? 1 : 0)
                .disabled(tabScelta != 0)

                NavigationStack {
                    RicercaView()
                }
                .opacity(tabScelta == 1 ? 1 : 0)
                .disabled(tabScelta != 1)

                NavigationStack {
                    PreferitiView()
                }
                .opacity(tabScelta == 2 ? 1 : 0)
                .disabled(tabScelta != 2)

                NavigationStack {
                    ProfiloView()
                }
                .opacity(tabScelta == 3 ? 1 : 0)
                .disabled(tabScelta != 3)
            }

            HStack {
                PulsanteTab(tabScelta: $tabScelta, indice: 0, icona: "house", titolo: "Home")
                PulsanteTab(tabScelta: $tabScelta, indice: 1, icona: "magnifyingglass", titolo: "Cerca")
                PulsanteTab(tabScelta: $tabScelta, indice: 2, icona: "heart", titolo: "Preferiti")
                PulsanteTab(tabScelta: $tabScelta, indice: 3, icona: "person", titolo: "Profilo")            
            }
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(30)
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.3), linewidth: 1)
            )
            .padding(.horizontal, 20)
            .padding(.top, 6)
        }
        .background(Color.white)       
    }
}

struct PulsanteTab: View {
    @Binding var tabScelta: Int
    var indice: Int
    var icona: String
    var titolo: String

    var body: some View {
        Button(action: {
            tabScelta = indice
        }) {
            VStack(spacing: 4) {
                Image(systemName: icona).font(.system(size: 20))
                Text(titolo).font(.caption)
            }
            .foregroundColor(tabScelta == indice ? coloreApp : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

