// Menu Principal

import SwiftUI

struct HomeView: View {
    @Binding var historial: [PlantaH]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Snaplant")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 34/255, green: 34/255, blue: 34/255))
                
                Image("logo_plant")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
                    
                NavigationLink(destination: FotosView(historial: $historial)) {
                    Text("Empezar")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color(red: 50/255, green: 205/255, blue: 50/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 205/255, green: 184/255, blue: 157/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    HomeView(historial: .constant([]))
}
