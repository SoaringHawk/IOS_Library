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
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchBooks()
    }
    
    func fetchHomePageBooks() {
        db.collection("books")
            .order(by: "title")
            .limit(to: 6)
            .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching books: \(error)")
                return
            }
            
            self.books = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Book.self)
            } ?? []
        }
    }
    
    func fetchBooks() {
        db.collection("books").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching books: \(error)")
                return
            }
            
            self.books = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Book.self)
            } ?? []
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
    
}
