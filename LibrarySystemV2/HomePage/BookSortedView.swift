//
//  BookSortedView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI


struct BookSortedView: View {
    @StateObject private var firebaseManager = BooksViewModel.shared  // Using shared FirebaseViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack{
                Text("Trending books ")
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            
            if firebaseManager.books.isEmpty {
                
                Text("Loading books...")
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(firebaseManager.books, id: \.id) { book in
                            BookGridItem(book: book)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            firebaseManager.fetchBooks()  // Ensure data is fetched when the view appears
        }
    }
}

struct BookGridItem: View {
    var book: Book
    
    var body: some View {
        VStack {
            
            Image(systemName: "book.fill")  // Using a system image as a placeholder
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .cornerRadius(8)
            
            // Book title
            Text(book.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            // Display author if available
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
    }
}

struct BookSortedView_Previews: PreviewProvider {
    static var previews: some View {
        BookSortedView()
    }
}

//
//#Preview {
//    BookSortedView()
//}
