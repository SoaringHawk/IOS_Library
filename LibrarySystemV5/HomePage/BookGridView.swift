//
//  BookGridView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 12/04/2025.
//

import SwiftUI
import Kingfisher
struct BookGridView: View {
    var book: Book

    var body: some View {
        VStack {
            KFImage(URL(string: book.imgUrl))
                .placeholder {
                    ProgressView()
                }
                .onFailure { error in
                    print("Image failed to load: \(error.localizedDescription)")
                }
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 180)
                .cornerRadius(8)
            

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

#Preview {
    let sampleBook = Book(
        id: "1",
        author: "Frank Herbert",
        category: "Science Fiction",
        isRented: false,
        title: "Dune",
        imgUrl: "dune",
        description: "Dune is a science fiction novel by Frank Herbert, set on the desert planet Arrakis, focusing on politics, religion, and ecology.",
        renter: [],
        pdfLink: "")
    BookGridView(book: sampleBook)
}
