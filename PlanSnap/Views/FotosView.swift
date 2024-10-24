// Seleccionar imagen y Tomar Foto

import SwiftUI
import Foundation
import UIKit

struct PlantaH: Identifiable {
    let id = UUID()
    let image: UIImage
    let nombre: String
}

struct FotosView: View {
    @Binding var historial: [PlantaH]
    @State private var selectedImage: UIImage?
    @State private var showPicker = false
    @State private var showCamera = false
    @State private var showAlert = false
    @State private var navigateToDetails = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Sube tu planta!")
                .font(.system(size: 45))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 34/255, green: 34/255, blue: 34/255))
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 200.0)
                    .padding(.top, 50)
                    .padding(.bottom, 50)
            } else {
                Image(systemName: "photo")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0)
                    .padding(.top, 50)
                    .padding(.bottom, 50)
            }
            
            Button("Abrir Fotos") {
                showPicker.toggle()
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 200, height: 50)
            .background(Color(red: 50/255, green: 205/255, blue: 50/255))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
            .sheet(isPresented: $showPicker) {
                PHPickerSwiftUI(selectedImage: $selectedImage)
            }
            
            Button("Tomar Foto") {
                showCamera.toggle()
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 200, height: 50)
            .background(Color(red: 50/255, green: 205/255, blue: 50/255))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showCamera) {
                CameraPickerView(selectedImage: $selectedImage).ignoresSafeArea()
            }
            
            Button {
                if selectedImage == nil {
                    showAlert = true
                } else {
                    navigateToDetails = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
            
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 60, height: 60)
            .background(Color.blue)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("No has agregado ninguna imagen"),
                    dismissButton: .default(Text("OK"))
                )
            }

            NavigationLink(destination: DetallePlantaView(image: selectedImage ?? UIImage(), historial: $historial), isActive: $navigateToDetails) {
                EmptyView()
            }
            .hidden()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FotosView(historial: .constant([])) 
}
