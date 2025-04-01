//
//  SearchView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct SearchView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var searchText: String

    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    isUserLoggedIn = false 
                }) {
                    Text("Log out")
                        .fontWeight(.medium)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()

                HStack {
                    TextField("Search for books...", text: $searchText)
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .frame(height: 44)
            }
            .padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isUserLoggedIn: .constant(false), searchText: .constant(""))
    }
}
