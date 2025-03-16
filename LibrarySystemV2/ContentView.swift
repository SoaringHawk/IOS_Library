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
                HomeScreen()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                
                
                MyBookShelfScreen()
                    .tabItem {
                        Label("MyBookShelfView", systemImage: "books.vertical")
                    }

                
                UserScreen()
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
