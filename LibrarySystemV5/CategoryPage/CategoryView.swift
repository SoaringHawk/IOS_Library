////
////  CategoryView.swift
////  LibrarySystem
////
////  Created by YunXian Xu on 2025-03-02.
////
//
import SwiftUI
import FirebaseFirestore



import SwiftUI

struct CategoryView: View {

    @Binding var selectedCategory: Category?
    var onSelect: (Category) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        onSelect(category)
                    }) {
                        Text(category.rawValue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedCategory == category ?
                                      Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedCategory == category ?
                                           .white : .primary)
                            .cornerRadius(20)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    CategoryView(
        selectedCategory: .constant(.fiction),
        onSelect: { _ in }
    )
}
