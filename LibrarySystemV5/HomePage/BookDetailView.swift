//
//  BookDetailView.swift
//  LibrarySystemV5
//
//  Created by sarah leventon on 2025-03-28.
//

import SwiftUI
import FirebaseFirestore

struct BookDetailView: View {
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
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(book.description)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Text(book.isRented ? "Currently Rented" : "Available for Rent")
                .foregroundColor(book.isRented ? .red : .green)
                .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(
            id: "1",
            author: "Frank Herbert",
            category: "Science Fiction",
            isRented: false,
            title: "Dune",
            imgUrl: "dune",
            description: "Dune is a science fiction novel by Frank Herbert, set on the desert planet Arrakis, focusing on politics, religion, and ecology."
        )
        
        BookDetailView(book: sampleBook)
    }
}
