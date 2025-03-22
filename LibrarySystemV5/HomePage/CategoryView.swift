////
////  CategoryView.swift
////  LibrarySystem
////
////  Created by YunXian Xu on 2025-03-02.
////
//
import SwiftUI


struct CategoryView: View {
    @Binding var selectedCategory: Category?
    var onCategorySelect: (Category) -> Void
    
    var body: some View {
        VStack {
            ForEach(Category.allCases, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    onCategorySelect(category)
                }) {
                    Text(category.rawValue)
                        .padding()
                        .background(selectedCategory == category ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.fiction), onCategorySelect: { _ in })
    }
}

