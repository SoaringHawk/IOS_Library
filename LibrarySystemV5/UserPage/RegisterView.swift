//
//  RegisterView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 22/03/2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isSecure: Bool = true
    @State private var errorMessage: String? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            Spacer()
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            HStack {
                
                    SecureField("Password", text: $password)
                
                            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                if password == confirmPassword {
                    firebaseManager.registerUser(email: email, password: password) { error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                        } else {
                            errorMessage = nil // Successful registration
                        }
                    }
                } else {
                    errorMessage = "Passwords do not match"
                }
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
