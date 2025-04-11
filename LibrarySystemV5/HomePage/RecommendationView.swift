//
//  RecommendationView.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-26.
//

import SwiftUI
import FirebaseFirestore

struct RecommendationView: View {
    @ObservedObject var firebaseManager: BooksViewModel
    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recommended for you")
                .font(.title)
                .padding(.leading)
            
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(firebaseManager.randomBooks, id: \.id) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        //This navigation link jump you to the books detail
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
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                                .frame(width: 120)
                        }
                    }
                }
            }
            Button("Refresh Recommendations") {
                firebaseManager.refreshRandomBooks()
            }
            .frame(maxWidth: .infinity) 
            .padding()
            .background(Color(red: 0.9, green: 0.9, blue: 0.9)) //light color
            .foregroundColor(.black)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .onAppear {
            if firebaseManager.randomBooks.isEmpty {
                firebaseManager.refreshRandomBooks()
            }
        }
    }
}

struct Recommendation_Previews: PreviewProvider {
    static var previews: some View {
        // fake BooksViewModel instance for the preview
        let mockFirebaseManager = BooksViewModel()
        mockFirebaseManager.randomBooks = [
            Book(id: "1", author: "Author 1", category: "Fiction", isRented: false, title: "Book 1", imgUrl: "https://example.com/image1.jpg", description: "Description 1", renter: [], pdfLink: ""),
            Book(id: "2", author: "Author 2", category: "Non-Fiction", isRented: true, title: "Book 2", imgUrl: "https://example.com/image2.jpg", description: "Description 2", renter: [], pdfLink: ""),
            Book(id: "3", author: "Author 3", category: "Science", isRented: false, title: "Book 3", imgUrl: "https://example.com/image3.jpg", description: "Description 3", renter: ["usertest@mail.com"], pdfLink: ""),
            Book(id: "4", author: "Author 4", category: "History", isRented: false, title: "Book 4", imgUrl: "https://example.com/image4.jpg", description: "Description 4", renter: ["usertest@mail.com"],
                 pdfLink: "")
        ]
        
        return RecommendationView(firebaseManager: mockFirebaseManager)
    }
}

