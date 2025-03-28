//
//  ContentView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MyBookShelfScreen()
                .tabItem {
                    Label("MyBookShelf", systemImage: "books.vertical")
                }
            
            
            UserScreen()
                .tabItem {
                    Label("User", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

