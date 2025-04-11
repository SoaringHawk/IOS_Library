//
//  MyBookShelfScreen.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct MyBookShelfScreen: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    @State private var navigationActive = false
    
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
                            if book.renter.contains(firebaseManager.loggedUser)  {
                                if let url = URL(string: book.pdfLink), url != nil {
                                    Button(action: {
                                        
                                        navigationActive = true
                                    }) {
                                        VStack {
                                            BookGridItem(book: book)
                                            Text("Read Book")
                                                .fontWeight(.bold)
                                                .foregroundColor(.blue)
                                                .padding(.top, 5)
                                        }
                                    }
                                    .background(
                                        NavigationLink(destination: Reader(url: url), isActive: $navigationActive) {
                                            EmptyView()
                                        }
                                        .hidden() // Hide the actual NavigationLink!
                                        //this is the link for the pdf
                                    )
                                }
                            }
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
