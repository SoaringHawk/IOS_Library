//
//  ContentView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-02-27.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                
                
                MyBookShelfView()
                    .tabItem {
                        Label("MyBookShelfView", systemImage: "books.vertical")
                    }

                
                UserView()
                    .tabItem {
                        Label("User", systemImage: "person")
                    }
                
            }

        }
    }
}




#Preview {
    ContentView()
}
