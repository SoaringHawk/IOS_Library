//
//  ContentView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn = false
    @StateObject private var firebaseManager = BooksViewModel.shared

    var body: some View {
        NavigationView{
            if isUserLoggedIn {
                
                if firebaseManager.isAdmin{
                    AdminPageView()
                }else{
                    TabView {
                        HomeScreen(isUserLoggedIn: $isUserLoggedIn)
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }

                        MyBookShelfScreen()
                            .tabItem {
                                Label("MyBookShelf", systemImage: "book.pages")
                            }
                        
                        CategoryScreen()
                            .tabItem {
                                Label("Category", systemImage: "books.vertical")
                            }

                        UserScreen(isUserLoggedIn: $isUserLoggedIn)
                            .tabItem {
                                Label("User", systemImage: "person")
                            }
                        
                    }
                }
                
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
            }
        }.tint(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

