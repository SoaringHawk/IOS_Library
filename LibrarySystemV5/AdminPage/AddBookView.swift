//
//  AddBookView.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var category = ""
    @State private var imgUrl = ""
    @State private var description = ""
    @State private var pdfLink = ""
    @State private var isRented = false
    @State private var renterInput = ""


    @StateObject private var firebaseManager = BooksViewModel.shared
    
    var body: some View {
        VStack {
            Text("Add New Book")
                .font(.largeTitle)
                .padding()
            
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Author", text: $author)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Category", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Image URL", text: $imgUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("PDF Link", text: $pdfLink)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Toggle("Is Rented", isOn: $isRented)
                .padding()
            
            TextField("Renter (if rented)", text: $renterInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add Book") {
                let renterArray = renterInput.isEmpty ? [] : [renterInput]
                let newBook = Book(
                    author: author,
                    category: category,
                    isRented: isRented,
                    title: title,
                    imgUrl: imgUrl,
                    description: description,
                    renter: renterArray,
                    pdfLink: pdfLink
                )
                firebaseManager.addBook(newBook)
                dismiss()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    AddBookView()
}
