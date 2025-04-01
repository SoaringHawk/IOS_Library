//
//  HomeScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI



struct HomeScreen: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    //    @State private var recommendedBooks: [Book] = []
    @State private var filteredBooks: [Book] = [] // Filtered books list
    @State private var selectedCategory: Category? = nil
    @State private var showLogin = false // Show login status
    @State private var searchText = "" // Search text
    
    
    var body: some View {

            NavigationStack{
                VStack {
                    SearchView(showLogin: $showLogin, searchText: $searchText)
                    
                    AdvertisementScrollView()
                    
                    RecommendationView()
                    
                    
                    BookSortedView()
                }
                .onAppear{
                    print("Hello")
                }
                .padding(.top)
        
                
                
            }


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


