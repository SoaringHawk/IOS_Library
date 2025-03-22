//
//  TabScreen.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct TabScreen: View {
    var body: some View {
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
            
        }.foregroundStyle(.white)
    }
}

#Preview {
    TabScreen()
}
