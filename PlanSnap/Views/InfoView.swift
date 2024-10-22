// Tomar Foto

import SwiftUI
import SwiftData

struct InfoView: View {
    @Environment(\.modelContext) private var context
    @Query private var plantas: [Planta]
    
    var body: some View {
        VStack {
            ForEach(plantas, id: \.self.id) { planta in
                // Filtrado de la planta según el modelo
                // let filteredPlanta = planta.filter { $0.id == zona.id }
//                Text(planta.nombre)
//                    .font(.system(size: 45))
//                    .fontWeight(.bold)
//                    .foregroundColor(Color(red: 34/255, green: 34/255, blue: 34/255))
//                AsyncImage(url: URL(string: planta.imagen)) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 80, height: 80)
//                } placeholder: {
//                    ProgressView()
//                        .frame(width: 80, height: 80)
//                }
                // Text(planta.descripción)
                // Text(planta.uso)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DataManager.addData(to: context)
        }
    }
}

#Preview {
    InfoView()
        .modelContainer(for: [Planta.self], inMemory: true)
}
