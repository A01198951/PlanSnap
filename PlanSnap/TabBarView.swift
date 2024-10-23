// Tomar Foto

import SwiftUI

struct TabBarView: View {
    @State private var historial: [PlantaH] = []

    var body: some View {
        TabView {
            HomeView(historial: $historial) 
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            PlantasView(historial: $historial)                 .tabItem {
                    Label("Mis Plantas", systemImage: "camera.macro.circle")
                }
        }
    }
}

#Preview {
    TabBarView()
}
