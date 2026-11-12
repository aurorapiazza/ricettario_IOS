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

        }
        .accentColor(.black)
    }
}

