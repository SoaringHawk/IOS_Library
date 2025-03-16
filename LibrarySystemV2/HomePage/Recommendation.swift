//
//  Recommendation.swift
//  LibrarySystemV2
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct Recommendation: View {
    @StateObject private var firebaseManager = BooksViewModel.shared

   

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.title)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // Use the books fetched from Firebase
                    ForEach(firebaseManager.books) { book in
                        VStack {
                            // Placeholder image until you get actual image URLs from Firebase
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 180)
                                .cornerRadius(8)
                            Text(book.title)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                }
            }
            .onAppear {
                // Fetch books when the view appears
                firebaseManager.fetchBooks()
             Task {
                firebaseManager.fetchBooks()
                // Check if the books array has data
                if firebaseManager.books.isEmpty {
                    print("No books found!")
                } else {
                    print("Books found: \(firebaseManager.books.count) books")
                }
            }
            }

            
        }
    }

}

#Preview {
    Recommendation()
}
