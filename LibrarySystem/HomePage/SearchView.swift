//
//  SearchView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct SearchView: View {
    @Binding var showLogin: Bool
    @Binding var searchText: String

    var body: some View {
        HStack {
            Button("Login") {
                showLogin.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()

            TextField("Search for books...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 44)
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showLogin: .constant(false), searchText: .constant(""))
    }
}

