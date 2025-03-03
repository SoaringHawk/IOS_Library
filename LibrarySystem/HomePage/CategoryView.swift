//
//  CategoryView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI


struct CategoryView: View {
    @Binding var selectedCategory: Category?
    var onCategorySelect: (Category) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        onCategorySelect(category)
                    }) {
                        Text(category.rawValue)
                            .padding()
                            .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.fiction), onCategorySelect: { _ in })
    }
}

