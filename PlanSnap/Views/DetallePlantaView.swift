// Detalle de las Plantas

import SwiftUI
import CoreML
import Vision
import UIKit
import VideoToolbox

struct DetallePlantaView: View {
    let image: UIImage
    @Binding var historial: [PlantaH]
    @State private var plantaIdentificada: String = "Preparando análisis..."
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(plantaIdentificada)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 70)
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 300)
                .cornerRadius(10)
                .padding()

            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            }
            
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
            
            if errorMessage != nil {
                Button("Reintentar") {
                    clasificarPlanta()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            clasificarPlanta()
        }
    }
    
    func prepararImagen(_ imagen: UIImage) -> CGImage? {
        let targetSize = CGSize(width: 299, height: 299)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, true, 1.0)
        imagen.draw(in: CGRect(origin: .zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage?.cgImage
    }
    
    func clasificarPlanta() {
        isLoading = true
        errorMessage = nil
        plantaIdentificada = "Analizando..."
        
        guard let cgImage = prepararImagen(image) else {
            errorMessage = "Error al procesar la imagen"
            isLoading = false
            return
        }
        
        guard let modelURL = Bundle.main.url(forResource: "PlantClassificationR", withExtension: "mlmodelc") else {
            print("No se encontró el archivo del modelo")
            errorMessage = "No se encontró el modelo de clasificación"
            isLoading = false
            return
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try MLModel(contentsOf: modelURL, configuration: config)
            
            guard let input = try? MLFeatureValue(
                cgImage: cgImage,
                pixelsWide: 299,
                pixelsHigh: 299,
                pixelFormatType: kCVPixelFormatType_32BGRA,
                options: nil
            ) else {
                errorMessage = "Error al preparar la imagen para el modelo"
                isLoading = false
                return
            }
            
            let inputName = model.modelDescription.inputDescriptionsByName.first?.key ?? "image"
            let inputFeatures = try MLDictionaryFeatureProvider(dictionary: [inputName: input])
            
            let prediction = try model.prediction(from: inputFeatures)
            
            if let outputFeatures = prediction.featureValue(for: "targetProbability")?.dictionaryValue as? [String: Double] {
                let bestPrediction = outputFeatures.max { $0.value < $1.value }
                
                DispatchQueue.main.async {
                    if let bestPrediction = bestPrediction {
                        plantaIdentificada = bestPrediction.key
                    } else {
                        plantaIdentificada = "No se pudo identificar la planta"
                    }
                    isLoading = false
                }
            } else {
                throw NSError(domain: "Predicción", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se pudieron obtener las probabilidades"])
            }
            
        } catch {
            DispatchQueue.main.async {
                isLoading = false
                print("Error al procesar: \(error)")
                errorMessage = "Error al procesar la imagen: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    DetallePlantaView(image: UIImage(systemName: "leaf")!, historial: .constant([]))
}
