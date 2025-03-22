//
//  MyBookShelfScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct MyBookShelfScreen: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            HStack{
                Text("My books")
                    .font(.title)
                    .padding(.leading)
                    .foregroundStyle(.black)
                Spacer()
            }
            
            
            if firebaseManager.books.isEmpty {
                
                Text("Loading books...")
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(firebaseManager.books, id: \.id) { book in
                            BookGridItem(book: book)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            firebaseManager.fetchBooks()  // Ensure data is fetched when the view appears
        }
    }
}

#Preview {
    MyBookShelfScreen()
}
