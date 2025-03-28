//
//  ContentView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn = false

    var body: some View {
        NavigationStack {
            if isUserLoggedIn {
                TabView {
                    HomeScreen(isUserLoggedIn: $isUserLoggedIn)
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
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

