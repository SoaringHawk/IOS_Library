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
                if (!firebaseManager.isAuthenticated){
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(width: 50, height: 10)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                

                Spacer()

                HStack{
                    TextField("Search for books...", text: $searchText)
                }
                
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
            }
            .padding()
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showLogin: .constant(false), searchText: .constant(""))
    }
}

