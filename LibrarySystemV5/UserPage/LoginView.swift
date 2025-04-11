//
//  LoginView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 22/03/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var firebaseManager = BooksViewModel.shared
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var errorMessage: String? = nil
    
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack {
            // light yellow background
            Color(red: 0.98, green: 0.96, blue: 0.90)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                Spacer()
                
                VStack(spacing: 20) {

                    Spacer()
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    HStack {
                        if isSecure {
                            SecureField("Password", text: $password)
                        } else {
                            TextField("Password", text: $password)
                        }
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        firebaseManager.loginUser(email: email, password: password) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            } else {
                                errorMessage = nil
                                isUserLoggedIn = true
                                firebaseManager.loggedUser = email
                                
                                
                            }
                        }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    HStack {
                        NavigationLink(destination: RegisterView()) {
                            Text("Don't have an account yet? Register")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.top, 150)
            }
        }
        

    }
}

#Preview {
    LoginView(isUserLoggedIn: .constant(false))
}
