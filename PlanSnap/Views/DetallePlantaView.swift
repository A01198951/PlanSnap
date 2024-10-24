// Detalle de las Plantas

import SwiftUI
import SwiftData
import CoreML
import Vision
import UIKit
import VideoToolbox

struct DetallePlantaView: View {
    let image: UIImage
    @Query private var plantas: [Planta]
    @Binding var historial: [PlantaH]
    @State private var plantaIdentificada: String = "Preparando análisis..."
    @State private var errorMessage: String?
    @State private var plantaDescripcion: String = ""
    @State private var plantaUso: String = ""
    @State private var isClassified: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(plantaIdentificada)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 120)

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200, maxHeight: 200)
                .cornerRadius(10)
                .padding()

            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding(.horizontal, 80)
                    .multilineTextAlignment(.center)
            }

            if !plantaDescripcion.isEmpty || !plantaUso.isEmpty {
                VStack(alignment: .leading, spacing: 20) {  // Increased spacing between sections
                    if !plantaDescripcion.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Descripción:")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(plantaDescripcion)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(6)
                        }
                    }

                    if !plantaUso.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Uso:")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(plantaUso)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(6)
                        }
                    }
                }
                .padding()
            }

            Spacer()
            
            if errorMessage != nil {
                Button("Reintentar") {
                    clasificarPlanta()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 140)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if !isClassified {
                clasificarPlanta()
            }
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
        errorMessage = nil
        plantaIdentificada = "Analizando..."
        plantaDescripcion = ""
        plantaUso = ""

        guard let cgImage = prepararImagen(image) else {
            errorMessage = "Error al procesar la imagen"
            return
        }

        guard let modelURL = Bundle.main.url(forResource: "PlantClassificationR", withExtension: "mlmodelc") else {
            print("No se encontró el archivo del modelo")
            errorMessage = "No se encontró el modelo de clasificación"
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
                return
            }

            let inputName = model.modelDescription.inputDescriptionsByName.first?.key ?? "image"
            let inputFeatures = try MLDictionaryFeatureProvider(dictionary: [inputName: input])

            let prediction = try model.prediction(from: inputFeatures)

            let umbralConfianza: Double = 0.1

            if let outputFeatures = prediction.featureValue(for: "targetProbability")?.dictionaryValue as? [String: Double] {
 
                let filteredPredictions = outputFeatures.filter { $0.value >= umbralConfianza }

                if let bestPrediction = filteredPredictions.max(by: { $0.value < $1.value }) {
                    DispatchQueue.main.async {
                        plantaIdentificada = bestPrediction.key
                        isClassified = true

                        if let plantaEncontrada = plantas.first(where: { $0.nombre.lowercased() == plantaIdentificada.lowercased() }) {
                            plantaDescripcion = plantaEncontrada.descripción
                            plantaUso = plantaEncontrada.uso

                            let nuevaPlanta = PlantaH(image: image, nombre: plantaIdentificada)
                            historial.append(nuevaPlanta)
                        } else {
                            errorMessage = "No se encontró información detallada para la planta identificada"
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Ninguna predicción superó el umbral de confianza"
                    }
                }
            } else {
                throw NSError(domain: "Predicción", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se pudieron obtener las probabilidades"])
            }

        } catch {
            DispatchQueue.main.async {
                print("Error al procesar: \(error)")
                errorMessage = "Error al procesar la imagen: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    DetallePlantaView(image: UIImage(systemName: "leaf")!, historial: .constant([]))
}
