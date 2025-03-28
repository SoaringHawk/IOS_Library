//
//  LoanData.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import Foundation

struct Loan: Identifiable, Codable {
    var id: UUID  // Using UUID as a unique identifier for every event
    var bookId: Int
    var userId: Int
    var checkoutDate: Date
    var dueDate: Date
}

func checkoutBook(bookId: Int, userId: Int) {
    let currentDate = Date()
    let dueDate = Calendar.current.date(byAdding: .day, value: 20, to: currentDate)!
    
    let newLoan = Loan(id: UUID(), bookId: bookId, userId: userId, checkoutDate: currentDate, dueDate: dueDate)
    addLoan(newLoan)
}

func addLoan(_ loan: Loan) {
    // Implement storage logic here, e.g., adding to a database or a local storage system
}
