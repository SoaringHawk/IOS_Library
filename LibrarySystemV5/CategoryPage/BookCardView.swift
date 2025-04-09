//
//  BookCardView.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-04-09.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: book.imgUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "book.fill")
                        .frame(height: 180)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(book.title)
                .font(.headline)
                .lineLimit(1)
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

//#Preview {
//    BookCardView()
//}
