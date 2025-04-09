//
//  AdminBookDetailView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI
import FirebaseFirestore

struct AdminBookDetailView: View {
    @ObservedObject private var firebaseManager = BooksViewModel.shared
    @State private var book: Book
    @State private var isRented: Bool
    @State private var renterEmail: String = ""
    
    init(book: Book) {
        _book = State(initialValue: book)
        _isRented = State(initialValue: book.isRented)
    }
    
    var body: some View {
        VStack {
            // Book details
            VStack(alignment: .leading, spacing: 10) {
                Text("Title: \(book.title)")
                    .font(.headline)
                
                Text("Author: \(book.author)")
                
                Text("Category: \(book.category)")
                
                Text("Description: \(book.description)")
                    .padding(.top, 5)
                
                AsyncImage(url: URL(string: book.imgUrl)) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 200, height: 300)
                } placeholder: {
                    ProgressView()
                }
            }
            .padding()
            
            Divider()
            
            // Modify book details section
            VStack(alignment: .leading, spacing: 15) {
                Text("Modify Book Information")
                    .font(.headline)
                
                Toggle(isOn: $isRented) {
                    Text("Is Rented")
                }
                
//                if isRented {
//                    TextField("Enter renter's email", text: $renterEmail)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.top, 5)
//                }
                
                Button(action: {
                    updateBookAttributes()
                }) {
                    Text("Update Book")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Function to update book attributes
    private func updateBookAttributes() {
        // Use the provided function to update the book data
        firebaseManager.updateBook(bookId: book.id ?? "", userEmail: "")
        
        // Update the local book object with the new rented status and renter email
        book.isRented = isRented
        book.renter = ""
        
        // Optionally: Add additional logic to show a success message
        
    }
}

#Preview {
    AdminBookDetailView(book: Book(id: "123", author: "Author Name", category: "Category", isRented: false, title: "Book Title", imgUrl: "https://example.com/image.jpg", description: "Book Description", renter: "", pdfLink: "https://example.com/book.pdf"))
}
