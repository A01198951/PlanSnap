// Aprendizaje

import SwiftUI

struct CustomPlanta: Identifiable {
    let id: Int
    let nombre: String
    let curiosidad: String
}

struct LearningView: View {
    
    let customColor = Color(red: 205/255, green: 184/255, blue: 157/255)

    let plantas = [
        CustomPlanta(id: 1, nombre: "Aloe Vera", curiosidad: """
            ¿Sabías que el gel de aloe vera no solo se usa para quemaduras solares? También puede ayudar a reducir el acné gracias a sus propiedades antiinflamatorias.
            """),
        CustomPlanta(id: 2, nombre: "Lavanda", curiosidad: """
            ¿Sabías que colocar un poco de lavanda debajo de tu almohada puede ayudarte a dormir mejor? Su aroma tiene efectos relajantes naturales.
            """),
        CustomPlanta(id: 3, nombre: "Albahaca", curiosidad: """
            ¿Sabías que la albahaca no solo sirve para cocinar? También puede actuar como repelente natural de mosquitos cuando se coloca cerca de las ventanas.
            """),
        CustomPlanta(id: 4, nombre: "Menta", curiosidad: """
            ¿Sabías que la menta no solo refresca el aliento? También puede aliviar dolores de cabeza si frotas una hoja de menta fresca en las sienes.
            """)
    ]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("¡Bienvenido!")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Descubre datos curiosos sobre plantas")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(Color(.systemGray6).opacity(0.9))
            .cornerRadius(10)
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(plantas) { planta in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(planta.nombre)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(planta.curiosidad)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
            .padding(.top)

            Spacer()
        }
        .background(customColor.ignoresSafeArea())
    }
}

#Preview {
    LearningView()
}
