// Detalle de las Plantas

import SwiftUI

struct DetallePlantaView: View {
    var image: UIImage
    @Binding var historial: [PlantaH]

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
        .onAppear {
        }
    }
}

#Preview {
    DetallePlantaView(image: UIImage(), historial: .constant([]))
}

