// Inicio de Sesion

import SwiftUI

struct Login: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()

            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.45))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)

            VStack {
                Text("Snaplant")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Usuario", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                SecureField("Contraseña", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                
                Button("Login") {
                    authenticateUser(username: username, password: password)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                
                .fullScreenCover(isPresented: $showingLoginScreen) {
                    TabBarView()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "1234" {
            wrongUsername = 0
            if password.lowercased() == "1234" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
