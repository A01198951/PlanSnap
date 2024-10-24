// Chatbot con Gemeni

import SwiftUI
import GoogleGenerativeAI

struct ChatBotView: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: "API KEVIN")
    
    @State private var messages: [(String, Bool)] = [("¡Hola! ¿En qué puedo ayudarte hoy?", false)]
    @State private var input: String = ""

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(messages.indices, id: \.self) { index in
                        let (message, isUser) = messages[index]
                        MessageBubble(message: message, isUser: isUser)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 10)

            HStack {
                TextField("Pregunta cualquier cosa", text: $input)
                    .textFieldStyle(.roundedBorder)
                
                
                Spacer()
                
                Button(action: {
                    if !input.isEmpty {
                        messages.append((input, true)) // Add user message
                        Task {
                            do {
                                let response = try await model.generateContent(input)
                                if let text = response.text {
                                    messages.append((text, false))
                                    input = ""
                                }
                            } catch {
                                messages.append(("Error: \(error.localizedDescription)", false))
                            }
                        }
                    }
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                })
            }
            .padding()
        }
        .background(Color(red: 205/255, green: 184/255, blue: 157/255).ignoresSafeArea())
    }
}

struct MessageBubble: View {
    let message: String
    let isUser: Bool
    
    var body: some View {
        Text(message)
            .padding()
            .foregroundColor(isUser ? .black : .white)
            .background(isUser ? Color.white : Color.gray)
            .cornerRadius(15)
            .frame(maxWidth: 300, alignment: isUser ? .trailing : .leading)
    }
}

#Preview {
    ChatBotView()
}
