//
//  HomeScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI



struct HomeScreen: View {
    @State private var allBooks: [Book] = booksData
    @State private var recommendedBooks: [Book] = booksData.shuffled()
    @State private var filteredBooks: [Book] = [] // 筛选后的书籍列表
    @State private var selectedCategory: Category? = nil // 当前选中的类别
    @State private var showLogin = false // 登录状态显示
    @State private var searchText = "" // 搜索文本

    var body: some View {
        VStack {
            
            SearchView(showLogin: $showLogin, searchText: $searchText)
            
           
            AdvertisementScrollView()

            RecommendedBooksView(books: recommendedBooks) {
                recommendedBooks = allBooks.shuffled()
            }
            
            CategoryView(selectedCategory: $selectedCategory, onCategorySelect: { category in
                selectedCategory = category
                filteredBooks = allBooks.filter { $0.category == category }
            })
            //我的名字叫
            BookSortedView(books: filteredBooks)
        }
        .padding(.top) 
    }
}





struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}





#Preview {
    HomeScreen()
}

