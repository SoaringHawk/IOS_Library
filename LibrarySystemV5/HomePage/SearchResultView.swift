//
//  SearchResultView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 13/04/2025.
//

import SwiftUI

struct SearchResultView: View {
    
    var searchText: String
    @StateObject private var firebaseManager = BooksViewModel.shared
    var body: some View {
        let results = firebaseManager.searchBooks(with: searchText)
        
        List(results) { book in
            NavigationLink(destination: BookDetailView(book: book)) {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Results for '\(searchText)'")
    }
}

#Preview {
    SearchResultView(searchText: "")
}
