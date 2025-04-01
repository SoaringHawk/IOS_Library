////
////  BooksViewModel.swift
////  LibrarySystem
////
////  Created by YunXian Xu on 2025-03-11.
////
//
import Foundation
import FirebaseFirestore
import Combine
//
class BooksViewModel: ObservableObject{
    static let shared = BooksViewModel()
    
    
    private let db = Firestore.firestore() // initialize the database
    
    @Published var books: [Book] = []
    @Published var randomBooks: [Book] = [] //for save random books
    @Published var isAuthenticated: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchBooks()
    }
    
    
    
    
    //Real-time fetching and updating of books information from the database
    func fetchBooks() {
        db.collection("books").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching books: \(error)")
                return
            }
            
//            self.books = querySnapshot?.documents.compactMap { document in
//                try? document.data(as: Book.self)
//            } ?? []
            //this is Jerry's original one, i modify it(Yunxian)
            
            
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
    

        
    
    
    
    
    
    
    
    
    //this function is for user login
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
                completion(nil) // Success
            } else {
                completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Incorrect password"]))
            }
        }
    }
    
    
    
    //This funciton is for user register
    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        
        // Check if the email is already registered
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            if snapshot?.documents.isEmpty == false {
                completion(NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "Email already registered"]))
                return
            }
            
            // Save user data
            db.collection("Users").addDocument(data: [
                "email": email,
                "password": password // Ideally, use Firebase Authentication and store only hashed passwords
            ]) { error in
                completion(error)
            }
        }
    }
    
    
    
    //    func addTodo(title: String) {
    //        let newTodo = Todo(title: title, isDone: false)
    //        do {
    //            try db.collection("todos").addDocument(from: newTodo)
    //        } catch {
    //            print("Error adding todo: \(error)")
    //        }
    //    }
    
    //    func updateTodoStatus(todo: Todo, isDone: Bool) {
    //        guard let todoId = todo.id else { return }
    //        db.collection("todos").document(todoId).updateData(["isDone": isDone])
    //    }
    
    //    func deleteTodo(todo: Todo) {
    //        guard let todoId = todo.id else { return }
    //        db.collection("todos").document(todoId).delete { error in
    //            if let error = error {
    //                print("Error deleting todo: \(error)")
    //            }
    //        }
    //    }
    
    //}
}
