// Tomar Foto

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            PlantasView()
                .tabItem {
                    Label("Mis Plantas", systemImage: "camera.macro.circle")
                }
        }
    }
}

#Preview {
    TabBarView()
}
