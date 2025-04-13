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
                VStack(spacing: 30) {
                    SearchView(isUserLoggedIn: $isUserLoggedIn)
                    
                    
                    AdvertisementScrollView()
                    
                    
                    RecommendationView(firebaseManager: BooksViewModel.shared)
                    
                    
                    BookSortedView()
                    
                    FooterInfoView()
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    
                    
                }
                .padding(.top, 10)
            }
        }
    }
}
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(isUserLoggedIn: .constant(true))
    }
}
