//
//  HomeScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var isUserLoggedIn: Bool
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchView(isUserLoggedIn: $isUserLoggedIn, searchText: $searchText)
                
                AdvertisementScrollView().padding(.bottom, 0)
                
                RecommendationView(firebaseManager: BooksViewModel.shared)
                
                BookSortedView()
            }
            .padding(.top)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(isUserLoggedIn: .constant(true))
    }
}
