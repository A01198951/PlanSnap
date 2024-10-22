// Tomar Foto

import SwiftUI

struct PlantasView: View {
    var body: some View {
        VStack {
            Text("Plantas")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    PlantasView()
}
