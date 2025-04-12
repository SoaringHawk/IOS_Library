//
//  BookSortedView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct BookSortedView: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    
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
                        ForEach(firebaseManager.books.prefix(6), id: \.id) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                    BookGridItem(book: book)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            firebaseManager.fetchBooks()
        }
    }
}

struct BookGridItem: View {
    var book: Book
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: book.imgUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 120, height: 180)
                         .cornerRadius(8)
                case .failure:
                    Image(systemName: "book.fill")
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(book.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
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
