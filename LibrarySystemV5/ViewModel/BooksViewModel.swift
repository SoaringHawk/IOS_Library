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
    @Published var randomBooks: [Book] = []
    @Published var userLibrary: [Book] = []
    private var cancellables = Set<AnyCancellable>()
    
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
        let db = Firestore.firestore()
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
                completion(nil) // success
            } else {
                completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Incorrect password"]))
            }
        }
    }

    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            if snapshot?.documents.isEmpty == false {
                completion(NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "Email already registered"]))
                return
            }
 
            db.collection("Users").addDocument(data: [
                "email": email,
                "password": password
            ]) { error in
                completion(error)
            }
        }
    }
}
