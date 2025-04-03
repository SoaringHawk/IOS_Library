//
//  CategoryScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-04-01.
//

import SwiftUI
import FirebaseFirestore    

struct CategoryScreen: View {
    @State private var selectedCategory: Category?
    @State private var books: [Book] = []
    @State private var lastDocument: DocumentSnapshot?
    @State private var isLoading = false
    @State private var canLoadMore = true
    

    private let pageSize = 4
    
    var body: some View {
        VStack(spacing: 0) {

            CategoryView(selectedCategory: $selectedCategory) { category in
                resetPagination()
                loadBooks(category: category)
            }
            
            
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible())],
                    spacing: 16
                ) {
                    ForEach(books) { book in
                        BookCard(book: book)
                    }
                    
                    
                    if isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
            }
            
            
            HStack {
                Button("Last page") {
                    loadPreviousPage()
                }
                .disabled(books.isEmpty)
                
                Spacer()
                
                Button("Next page") {
                    loadNextPage()
                }
                .disabled(!canLoadMore || isLoading)
            }
            .padding()
        }
        .onAppear {
            loadBooks(category: nil)
        }
    }
    
    // Firebase this need to modify, i need to combine with func in bookviewmodel
    private func loadBooks(category: Category?) {
        isLoading = true
        let query = Firestore.firestore().collection("books")
            .whereField("category", isEqualTo: category?.rawValue ?? "")
            .limit(to: pageSize)
        
        if let lastDoc = lastDocument {
            query.start(afterDocument: lastDoc)
        }
        
        query.getDocuments { snapshot, error in
            isLoading = false
            guard let documents = snapshot?.documents else { return }
            
            let newBooks = documents.compactMap { try? $0.data(as: Book.self) }
            self.books.append(contentsOf: newBooks)
            self.lastDocument = documents.last
            self.canLoadMore = newBooks.count == pageSize
        }
    }
    
    private func resetPagination() {
        books.removeAll()
        lastDocument = nil
        canLoadMore = true
    }
    
    private func loadNextPage() {
        guard canLoadMore, let category = selectedCategory else { return }
        loadBooks(category: category)
    }
    
    private func loadPreviousPage() {
        // this need to modifty more
        // backt to page one
        resetPagination()
        loadBooks(category: selectedCategory)
    }
}


struct BookCard: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            Text(book.author)
                .font(.subheadline)
            Text(book.category)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

#Preview {
    CategoryScreen()
}
