
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer().frame(height: 20)
            
            VStack(spacing: 8) {
                Text("Bentornato!")
                    .font(.system(size: 32, weight: .bold))
                Text("Accedi per le tue ricette preferite")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.system(size: 16, weight: .bold))
                    
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        TextField("Username", text: $username)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                }
            }
            
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}
