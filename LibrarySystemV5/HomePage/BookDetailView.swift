//
//  BookDetailView.swift
//  LibrarySystemV5
//
//  Created by sarah leventon on 2025-03-28.
//

import SwiftUI
import FirebaseFirestore

struct BookDetailView: View {
    var book: Book
    @StateObject private var firebaseManager = BooksViewModel.shared
    @State private var isButtonActive = true
    @State private var isAlreadyRented = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: book.imgUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 180)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "book.fill")
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(book.description)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
//            if(isButtonActive){
//                Text(book.isRented ? "Currently Rented" : "Available for Rent")
//                    .foregroundColor(book.isRented ? .red : .green)
//                    .padding(.top)
//                    .padding(.bottom)
//            }

            
            
            
                
            
            if isAlreadyRented {
                Button(action: {
                    firebaseManager.toggleBookRental(bookId: book.id!, isRenting: false, userEmail: firebaseManager.loggedUser)
                    isAlreadyRented = false
                }) {
                    Text("Return this book")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    firebaseManager.toggleBookRental(bookId: book.id!, isRenting: true, userEmail: firebaseManager.loggedUser)
                    isAlreadyRented = true
                }) {
                    Text("Rent this book")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

                }
                .onAppear {
                    getRenters(of: book.id!) { renters in
                        if let renters = renters {
                            isAlreadyRented = renters.contains(firebaseManager.loggedUser)
                        }
                    }
            
            
            

            
            
            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getRenters(of bookId: String, completion: @escaping ([String]?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("books").document(bookId).getDocument { document, error in
            if let error = error {
                print("Error getting book document: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let renters = data?["renter"] as? [String]
                completion(renters)
            } else {
                completion(nil)
            }
        }
    }
    
    

    
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(
            id: "1",
            author: "Frank Herbert",
            category: "Science Fiction",
            isRented: false,
            title: "Dune",
            imgUrl: "dune",
            description: "Dune is a science fiction novel by Frank Herbert, set on the desert planet Arrakis, focusing on politics, religion, and ecology.",
            renter: [],
            pdfLink: "")
        
        BookDetailView(book: sampleBook)
    }
}
