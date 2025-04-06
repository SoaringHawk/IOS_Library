//
//  UserScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct UserScreen: View {
    @State private var userName = "Bibabu"
    @ObservedObject private var firebaseManager = BooksViewModel.shared
    @State private var userEmail = "Balala@gmail.com"
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer(minLength: 40)

            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            
            
            Text(firebaseManager.loggedUser)
                .font(.title)
                .fontWeight(.medium)
            
            
//            Text(viewModel.loggedUser)
//                .font(.callout)
//                .foregroundColor(.gray)
            
            
            if isUserLoggedIn {
                Button(action: {
                    
                    isUserLoggedIn = false
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            } else {
                Button(action: {
                    
                    isUserLoggedIn = true
                }) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserScreen(isUserLoggedIn: .constant(true))
    }
}
