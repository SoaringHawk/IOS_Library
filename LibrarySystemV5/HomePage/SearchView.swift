//
//  SearchView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct SearchView: View {
    @Binding var isUserLoggedIn: Bool
    @StateObject private var firebaseManager = BooksViewModel.shared
    
    @State private var searchText: String = ""
    @State private var navigateToResults = false
    @State private var submittedText = ""

    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    isUserLoggedIn = false 
                }) {
                    Text("Log out")
                        .fontWeight(.medium)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()

                TextField("Search for books...", text: $searchText, onCommit: {
                                    submittedText = searchText
                                    navigateToResults = true
                                })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            }
                            .padding()

                            
                            

                            // NavigationLink to SearchResultsView
                            NavigationLink(
                                destination: SearchResultView(
                                    searchText: submittedText
                                ),
                                isActive: $navigateToResults
                            ) {
                                EmptyView()
                            }
            }
            .padding(.horizontal)
        }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isUserLoggedIn: .constant(false))
    }
}
