//
//  CategoryScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-04-01.
//

import SwiftUI
import FirebaseFirestore    


struct CategoryScreen: View {
    // 状态变量
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
            loadBooks() // 页面出现时加载默认分类的书籍
        }
    }
    
    // 分类选择器视图
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
    
    // 书籍网格视图
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
                        .gridCellColumns(2) // 跨两列显示加载指示器
                }
            }
            .padding()
        }
    }
    
    // 分页控制视图
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
    
    // 加载书籍数据
    private func loadBooks() {
        guard !isLoading else { return }
        
        isLoading = true
        
        // 创建基础查询
        var query = Firestore.firestore().collection("books")
            .whereField("category", isEqualTo: selectedCategory.rawValue)
            .limit(to: pageSize)
        
        // 安全处理分页
        if !pageDocuments.isEmpty {
            let safeIndex = min(currentPage, pageDocuments.count - 1)
            if let startDoc = pageDocuments[safeIndex] {
                query = query.start(afterDocument: startDoc)
            }
        }
        
        query.getDocuments { snapshot, error in
            isLoading = false
            
            // 错误处理
            if let error = error {
                print("加载书籍错误: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("没有获取到文档或文档为空")
                canLoadMore = false
                return
            }
            
            // 解析书籍数据
            do {
                let newBooks = try documents.map { try $0.data(as: Book.self) }
                books = newBooks
                
                // 更新分页游标
                updatePageDocuments(with: documents.last)
                
                // 检查是否还能加载更多
                canLoadMore = documents.count == pageSize
            } catch {
                print("解析书籍数据错误: \(error)")
            }
        }
    }
    
    // 更新分页文档数组
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
        pageDocuments = [nil] // 重置为初始状态
        canLoadMore = true
    }
}

// 书籍卡片视图
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


