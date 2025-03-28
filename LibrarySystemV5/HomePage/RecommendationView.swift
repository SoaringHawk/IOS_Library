//
//  RecommendationView.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-26.
//

import SwiftUI
import FirebaseFirestore

struct RecommendationView: View {
    @StateObject private var firebaseManager = BooksViewModel.shared  // 使用共享的 BooksViewModel 实例

    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)  // 两列布局

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.title)
                .padding(.leading)

            // 使用 LazyVGrid 显示随机推荐的书籍
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(firebaseManager.randomBooks, id: \.id) { book in
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
                            .fontWeight(.semibold)
                            .frame(width: 120)
                    }
                    .padding(.leading)
                }
            }
            Button("Refresh Recommendations") {
                firebaseManager.refreshRandomBooks()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .onAppear {
            if firebaseManager.randomBooks.isEmpty {
                firebaseManager.refreshRandomBooks()
            }
        }
    }
    
    //    @StateObject private var firebaseManager = BooksViewModel.shared
    //    @State private var randomBooks: [Book] = []
    //
    //    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    //
    //    var body: some View {
    //        VStack(alignment: .leading) {
    //            Text("Recommended for you")
    //                .font(.title)
    //                .padding(.leading)
    //
    //            LazyVGrid(columns: gridItems, spacing: 20) {
    //                ForEach(randomBooks, id: \.id) { book in
    //                    VStack {
    //                        AsyncImage(url: URL(string: book.imgUrl)) { phase in
    //                            switch phase {
    //                            case .empty:
    //                                ProgressView()
    //                            case .success(let image):
    //                                image.resizable()
    //                                     .scaledToFit()
    //                                     .frame(width: 120, height: 180)
    //                                     .cornerRadius(8)
    //                            case .failure:
    //                                Image(systemName: "book.fill")
    //                            @unknown default:
    //                                EmptyView()
    //                            }
    //                        }
    //                        Text(book.title)
    //                            .fontWeight(.semibold)
    //                            .frame(width: 120)
    //                    }
    //                    .padding(.leading)
    //                }
    //            }

//    func refreshRecommendations() {
//        firebaseManager.fetchBooks() // This will automatically update books when changes happen
//        randomizeBooks()
//    }
//
//    func randomizeBooks() {
//        // Ensure this is called after a slight delay or ensure it's called once books have been updated
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            if !firebaseManager.books.isEmpty {
//                randomBooks = Array(firebaseManager.books.shuffled().prefix(4))
//            }
//        }
//    }
}



struct Recommendation_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView()
    }
}
