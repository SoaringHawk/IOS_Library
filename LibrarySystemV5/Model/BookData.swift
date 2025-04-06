//
//  BookData.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import Foundation
import FirebaseFirestore

struct Book: Identifiable, Codable {
    @DocumentID var id: String?
    let author: String
    let category: String
    let isRented: Bool
    let title: String
    let imgUrl: String
    let description: String
    let renter: String
    let pdfLink: String
}


//Defines the categories of books available in the library.
enum Category: String, Codable, CaseIterable {
    case fiction = "Fiction"
    case scienceFiction = "ScienceFiction"
    case history = "History"
    case economics = "Economics"
    case fantasy = "Fantasy"
    case psychology = "Psychology"
}

//let booksData: [Book] = [
//    Book(id: 1, title: "L'Étranger", author: "Albert Camus", category: .fiction, image: "etranger"),
//    Book(id: 2, title: "Gone with the Wind", author: "Margaret Mitchell", category: .fiction, image: "GoneWithTheWind"),
//    Book(id: 3, title: "Little Women", author: "Louisa May Alcott", category: .fiction, image: "LittleWomen"),
//    Book(id: 4, title: "Pride and Prejudice", author: "Jane Austen", category: .fiction, image: "PrideAndPrejudice"),
//    Book(id: 5, title: "The Handmaid's Tale", author: "Margaret Atwood", category: .fiction, image: "The_Handmaid's_Tale"),
//    Book(id: 6, title: "The Little Prince", author: "Antoine de Saint-Exupéry", category: .fiction, image: "TheLittlePrince"),
//    
//    // Science Fiction & Fantasy
//    Book(id: 7, title: "Dune", author: "Frank Herbert", category: .scienceFiction, image: "Dune"),
//    Book(id: 8, title: "Harry Potter", author: "J.K. Rowling", category: .fantasy, image: "HarryPotter"),
//    Book(id: 9, title: "The Three-Body Problem", author: "Liu Cixin", category: .scienceFiction, image: "ThreeBodyProblem")
//]
