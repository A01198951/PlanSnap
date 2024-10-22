// Tomar Foto

import SwiftUI

struct FotosView: View {
    var body: some View {
        VStack {
            Text("Fotos")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 205/255, green: 184/255, blue: 157/255))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FotosView()
}
