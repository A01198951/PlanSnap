// Historial de mis plantas

import SwiftUI

struct PlantasView: View {
    @Binding var historial: [PlantaH]
    
    var body: some View {
        VStack {
            Spacer(minLength: 60)
            
            Text("Historial de Plantas")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if historial.isEmpty {
                Text("No hay plantas en el historial.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(historial) { planta in
                        HStack {
                            Image(uiImage: planta.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                            
                            Spacer()
                            
                            Text(planta.nombre)
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(PlainListStyle()) 
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
    }
    func deleteItem(at offsets: IndexSet) {
        historial.remove(atOffsets: offsets)
    }
}


#Preview {
    let pruebaImagen = UIImage(systemName: "leaf")! 
    let historialDePrueba = [PlantaH(image: pruebaImagen, nombre: "")]
    PlantasView(historial: .constant(historialDePrueba))
}

