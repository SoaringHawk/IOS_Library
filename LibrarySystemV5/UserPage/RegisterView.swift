//
//  RegisterView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 22/03/2025.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var firebaseManager = BooksViewModel.shared
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil

    @Environment(\.dismiss) var dismiss 

    var body: some View {
        
        ZStack {
            Color(red: 0.98, green: 0.96, blue: 0.90)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
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

                    SecureField("Password", text: $password)
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
                                    errorMessage = nil
                                    dismiss()
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
                .padding(.top, 150)
            }
        }

    }
}

#Preview {
    RegisterView()
}
