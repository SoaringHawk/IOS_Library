//
//  AddUserView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI



struct AddUserView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var firebaseManager = BooksViewModel.shared
    
    var body: some View {
        VStack {
            Text("Add New User")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add User") {
                firebaseManager.addUser(email: email, password: password)
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}


#Preview {
    AddUserView()
}
