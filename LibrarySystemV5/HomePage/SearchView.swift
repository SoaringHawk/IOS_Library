//
//  SearchView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct SearchView: View {
    @Binding var showLogin: Bool
    @Binding var searchText: String
    @StateObject private var firebaseManager = BooksViewModel.shared


    var body: some View {
        NavigationStack {
            HStack {
                //The login button will show up if the user is not login
                if (!firebaseManager.isAuthenticated){
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .fontWeight(.medium)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                

                Spacer()

                HStack{
                    TextField("Search for books...", text: $searchText)
                }
                .padding(.all, 10) 
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .frame(height: 44)
            }
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showLogin: .constant(false), searchText: .constant(""))
    }
}

