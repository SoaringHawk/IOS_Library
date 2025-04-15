////
////  BooksViewModel.swift
////  LibrarySystem
////
////  Created by YunXian Xu on 2025-03-11.
////

import Foundation
import FirebaseFirestore
import Combine

class BooksViewModel: ObservableObject{
    static let shared = BooksViewModel()
    private let db = Firestore.firestore() // initialize the database
    
    
    @Published var books: [Book] = []
    @Published var randomBooks: [Book] = [] //this is for home page random select book view
    @Published var userLibrary: [Book] = []
    @Published var loggedUser: String = ""
    @Published var isAdmin: Bool = false
    private var cancellables = Set<AnyCancellable>()
    

    //Begin ---------------- modifty for Catefory Page
    struct PaginatedResponse {
        var books: [Book]
        var lastDocument: DocumentSnapshot? // for firebase pagination
    }
    //END ----------------- modifty for Catefory Page
    
    init() {
        fetchBooks()
    }
    
    // real-time fetching and updating of books information from the database
    func fetchBooks() {
        db.collection("books").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching books: \(error)")
                return
            }
            
            //            self.books = querySnapshot?.documents.compactMap { document in
            //                try? document.data(as: Book.self)
            //            } ?? []
            
            self.books = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Book.self)
            } ?? []
            
            
            self.refreshRandomBooks()
            
        }
    }
    
    
    func searchBooks(with text: String) -> [Book] {
            books.filter {
                $0.title.localizedCaseInsensitiveContains(text) ||
                $0.author.localizedCaseInsensitiveContains(text)
            }
        }
    
    func refreshRandomBooks() {
        DispatchQueue.main.async {
            self.randomBooks = Array(self.books.shuffled().prefix(4))
        }
    }
    
    
    
    
    func addToLibrary(book: Book) {
            db.collection("userLibrary").addDocument(data: [
                "id": book.id,
                "title": book.title,
                "author": book.author,
                "imgUrl": book.imgUrl
            ]) { error in
                if let error = error {
                    print("Error adding book to library: \(error)")
                } else {
                    print("Book added to library")
                }
            }
        }

    
    
    
    
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                return
            }
            
            let userData = document.data()
            
            if let storedPassword = userData["password"] as? String, storedPassword == password {
                        
                // Print the admin value before updating isAdmin
                if let adminValue = userData["isAdmin"] as? Bool {
                    print("Admin Value: \(adminValue)")  // Debugging line
                    self.isAdmin = adminValue
                }
                
                completion(nil) // Success
                
            } else {
                completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Incorrect password"]))
            }
        }
    }

    
    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        
        self.db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            if snapshot?.documents.isEmpty == false {
                completion(NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "Email already registered"]))
                return
            }
 
            self.db.collection("Users").addDocument(data: [
                "email": email,
                "password": password
            ]) { error in
                completion(error)
            }
        }
    }
    
    func updateBook(bookId: String, isRented: Bool, userEmail: String) {
        let db = Firestore.firestore()
        
        db.collection("books").document(bookId).updateData([
            "isRented": isRented,
            "renter": isRented ? FieldValue.arrayUnion([userEmail]) : []
        ]) { error in
            if let error = error {
                print("Error updating book: \(error.localizedDescription)")
            } else {
                print("Book successfully updated.")
                self.fetchBooks()
            }
        }
    }
    
    func toggleBookRental(bookId: String, isRenting: Bool, userEmail: String) {
        let db = Firestore.firestore()
        let bookRef = db.collection("books").document(bookId)

        let updates: [String: Any] = [
            "isRented": isRenting,
            "renter": isRenting ? FieldValue.arrayUnion([userEmail]) : FieldValue.arrayRemove([userEmail])
        ]

        bookRef.updateData(updates) { error in
            if let error = error {
                print("Error updating book: \(error.localizedDescription)")
            } else {
                print("Book rental updated successfully.")
                self.fetchBooks()
            }
        }
    }
    
    func returnBook(bookId: String, userEmail: String) {
        let db = Firestore.firestore()

        db.collection("books").document(bookId).updateData([
            "renter": FieldValue.arrayRemove([userEmail])
        ]) { error in
            if let error = error {
                print("Error returning book: \(error.localizedDescription)")
            } else {
                print("Book successfully returned.")
            }
        }
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
                print("Book not found.")
                completion(nil)
            }
        }
    }
    
    // Add Book
        func addBook(_ book: Book) {
            do {
                let _ = try db.collection("Books").addDocument(from: book)
            } catch {
                print("Error adding book: \(error)")
            }
        }
        
        // Delete Book
        func deleteBook(bookId: String) {
            db.collection("Books").document(bookId).delete { error in
                if let error = error {
                    print("Error deleting book: \(error)")
                }
            }
        }
        
        // Add User
        func addUser(email: String, password: String) {
            // Firebase Authentication or Database logic to add a user. to come
            print("Adding user with email: \(email)")
        }
}
