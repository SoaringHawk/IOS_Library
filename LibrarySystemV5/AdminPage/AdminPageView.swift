//
//  AdminPageView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI

struct AdminPageView: View {
    @StateObject private var firebaseManager = BooksViewModel.shared
    
    @State private var showingAddBook = false
    @State private var showingAddUser = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Admin Actions Section
//                HStack {
//                    Button(action: {
//                        showingAddBook = true
//                    }) {
//                        Text("Add Book")
//                            .font(.title2)
//                            .padding()
//                            .background(Color.green)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                    
//                    Button(action: {
//                        showingAddUser = true
//                    }) {
//                        Text("Add User")
//                            .font(.title2)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//                .padding()
                
                // Books List
                List {
                    ForEach(firebaseManager.books) { book in
                        NavigationLink(destination: AdminBookDetailView(book: book)) {
                            HStack {
                                AsyncImage(url: URL(string: book.imgUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 90)
                                    case .failure:
                                        Image(systemName: "book.fill")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .fontWeight(.bold)
                                    Text(book.author)
                                        .foregroundColor(.gray)
                                    Text(book.isRented ? "Rented" : "Available")
                                        .foregroundColor(book.isRented ? .red : .green)
                                }
                                Spacer()
//                                Button(action: {
//                                    firebaseManager.deleteBook(bookId: book.id!)
//                                }) {
//                                    Image(systemName: "trash")
//                                        .foregroundColor(.red)
//                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Admin Dashboard")
                .navigationBarItems(trailing: EditButton())
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
            .sheet(isPresented: $showingAddUser) {
                AddUserView()
            }
        }
    }
}

#Preview {
    AdminPageView()
}
