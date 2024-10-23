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
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    .onDelete(perform: deleteItem)
                }
                .padding()
                .padding(.bottom, 20)
                .listStyle(PlainListStyle()) 
            }
            Spacer()
        }
        .padding(.bottom, 20)
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

