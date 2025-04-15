//
//  CategoryScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-04-01.
//

import SwiftUI
import FirebaseFirestore    


struct CategoryScreen: View {
    // State variables
    @State private var selectedCategory: Category = .fiction //The Fiction category is selected by default
    @State private var books: [Book] = []
    @State private var isLoading = false
    @State private var canLoadMore = true
    @State private var currentPage = 0
    @State private var pageDocuments: [DocumentSnapshot?] = [nil] // Store the last document per page
    
    
    private let pageSize = 6 // page number
    private let gridItems = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2) // Grid Layout
    
    var body: some View {
        VStack(spacing: 0) {
            // Category selection horizontal scroll bar
            categorySelector
            
            // Book Grid
            bookGrid
            
            // Paging Control
            paginationControls
        }
        .onAppear {
            loadBooks() // Load the default category of books when the page appears
        }
    }
    
    // Category selector view
    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        resetPagination()
                        loadBooks()
                    }) {
                        Text(category.rawValue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedCategory == category ? Color.white : Color.primary)
                            .cornerRadius(20)
                    }
                }
            }
            .padding()
        }
    }
    
    // Books Grid View
    private var bookGrid: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookCardView(book: book)
                    }
                }
                
                if isLoading {
                    ProgressView()
                        .gridCellColumns(2)
                }
            }
            .padding()
        }
    }
    
    
    private var paginationControls: some View {
        HStack {
            Button("Last Page") {
                loadPreviousPage()
            }
            .disabled(currentPage <= 0 || isLoading)
            
            Spacer()
            
            Text("Page \(currentPage + 1)")
            
            Spacer()
            
            Button("Next Page") {
                loadNextPage()
            }
            .disabled(!canLoadMore || isLoading)
        }
        .padding()
    }
    
    // load book data
    private func loadBooks() {
        guard !isLoading else { return }
        
        isLoading = true
        
        
        var query = Firestore.firestore().collection("books")
            .whereField("category", isEqualTo: selectedCategory.rawValue)
            .limit(to: pageSize)
        
        // handle pages
        if !pageDocuments.isEmpty {
            let safeIndex = min(currentPage, pageDocuments.count - 1)
            if let startDoc = pageDocuments[safeIndex] {
                query = query.start(afterDocument: startDoc)
            }
        }
        
        query.getDocuments { snapshot, error in
            isLoading = false
            
            
            if let error = error {
                print("loading book error: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("The file is empty")
                canLoadMore = false
                return
            }
            
            
            do {
                let newBooks = try documents.map { try $0.data(as: Book.self) }
                books = newBooks
                
                
                updatePageDocuments(with: documents.last)
                
                
                canLoadMore = documents.count == pageSize
            } catch {
                print("anayse book data error: \(error)")
            }
        }
    }
    
    // Update an array of paginated documents
    private func updatePageDocuments(with document: DocumentSnapshot?) {
        if currentPage + 1 >= pageDocuments.count {
            pageDocuments.append(document)
        } else {
            pageDocuments[currentPage + 1] = document
        }
    }
    
    // For category page next page
    private func loadNextPage() {
        guard canLoadMore, !isLoading else { return }
        currentPage += 1
        loadBooks()
    }
    
    // For category page last page
    private func loadPreviousPage() {
        guard currentPage > 0, !isLoading else { return }
        currentPage -= 1
        loadBooks()
    }
    
    // 
    private func resetPagination() {
        books.removeAll()
        currentPage = 0
        pageDocuments = [nil]
        canLoadMore = true
    }
}


//struct BookCardView: View {
//    let book: Book
//    
//    var body: some View {
//        VStack {
//            AsyncImage(url: URL(string: book.imgUrl)) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image.resizable()
//                        .scaledToFit()
//                        .frame(height: 180)
//                        .cornerRadius(8)
//                case .failure:
//                    Image(systemName: "book.fill")
//                        .frame(height: 180)
//                @unknown default:
//                    EmptyView()
//                }
//            }
//            
//            Text(book.title)
//                .font(.headline)
//                .lineLimit(1)
//            Text(book.author)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(radius: 2)
//    }
//}

#Preview {
    CategoryScreen()
}


