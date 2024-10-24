// Tomar Foto

import SwiftUI

struct TabBarView: View {
    @Environment(\.modelContext) private var context
    @State private var historial: [PlantaH] = []

    var body: some View {
        TabView {
            HomeView(historial: $historial)
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }

            PlantasView(historial: $historial)
                .tabItem {
                    Label("Mis Plantas", systemImage: "camera.macro.circle")
                }

            LearningView()
                .tabItem {
                    Label("Aprendizaje", systemImage: "book")
                }
        }
        .onAppear {
            DataManager.addData(to: context)
        }
    }
}

#Preview {
    TabBarView()
        .modelContainer(for: [Planta.self], inMemory: true)
}

