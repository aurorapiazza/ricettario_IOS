import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }

            NavigationStack {
                RicercaView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Cerca")
            }

            NavigationStack {
                PreferitiView()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Preferiti")
            }

            NavigationStack {
                ProfiloView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profilo")
            }

        }
        .accentColor(.black)
    }
}

