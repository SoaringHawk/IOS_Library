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
    @State private var selectedPdfURL: URL?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
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
                                            selectedPdfURL = URL(string: book.pdfLink)
                                            navigationActive = true
                                        }) {
                                            VStack {
                                                BookGridView(book: book)
                                                Text("Read Book")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.blue)
                                                    .padding(.top, 5)
                                            }
                                        }
                                        .background(
                                            NavigationLink(
                                                destination: selectedPdfURL.map { Reader(url: $0) },
                                                isActive: $navigationActive
                                            ) {
                                                EmptyView()
                                            }
                                            .hidden()
                                        )                                }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar) //modify for bar
            .onAppear {
                firebaseManager.fetchBooks()// Ensure data is fetched when the view appears
        }


        }
    }
}



#Preview {
    MyBookShelfScreen()
}
