//
//  RecommendedBooksView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI



import SwiftUI

struct RecommendedBooksView: View {
    
    var books: [Book]
    var exploreMoreAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.title)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(books, id: \.id) { book in
                        BookView(book: book)
                    }
                }
            }

            ExploreMoreButton(action: exploreMoreAction)
                .padding()
        }
    }
}

struct BookView: View {
    var book: Book

    var body: some View {
        VStack {
            Image(book.image)
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

struct ExploreMoreButton: View {
    var action: () -> Void

    var body: some View {
        Button("Explore More", action: action)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct RecommendedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedBooksView(books: booksData, exploreMoreAction: {})
    }
}


//
//#Preview {
//    RecommendedBooksView()
//}
