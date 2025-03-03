//
//  BookSortedView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI


struct BookSortedView: View {
    var books: [Book]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(books, id: \.id) { book in
                    BookGridItem(book: book)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BookGridItem: View {
    var book: Book
    
    var body: some View {
        VStack {
            Image(book.image)  
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .cornerRadius(8)
            Text(book.title)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
    }
}

struct BookSortedView_Previews: PreviewProvider {
    static var previews: some View {
        BookSortedView(books: booksData)
    }
}

//
//#Preview {
//    BookSortedView()
//}
