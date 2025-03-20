////
////  RecommendedBooksView.swift
////  LibrarySystem
////
////  Created by YunXian Xu on 2025-03-02.
////
//
//import SwiftUI
//import Foundation
//import FirebaseFirestore
//
//class
//
//struct RecommendedBooksView: View {
//    @StateObject private var firebaseManager = FirebaseViewModel.shared
//
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Recommended for you")
//                .font(.title)
//                .padding(.leading)
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    // Use the books fetched from Firebase
//                    ForEach(firebaseManager.books) { book in
//                        VStack {
//                            // Placeholder image until you get actual image URLs from Firebase
//                            Image(systemName: "book.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 120, height: 180)
//                                .cornerRadius(8)
//                            Text()
//                                .fontWeight(.semibold)
//                        }
//                        .padding(.leading)
//                    }
//                }
//            }
//            .onAppear {
//                // Fetch books when the view appears
//                firebaseManager.fetchBooks()
//            }
//
//            
//        }
//    }
//}
//
//
//
//struct ExploreMoreButton: View {
//    var action: () -> Void
//
//    var body: some View {
//        Button("Explore More", action: action)
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//    }
//}
//
//struct RecommendedBooksView_Previews: PreviewProvider {
//    // Use mock data for previews
//    static var previews: some View {
//        RecommendedBooksView(exploreMoreAction: {})
//            .environmentObject(FirebaseViewModel())  // Provide FirebaseViewModel for previews
//    }
//}
//
//
////
////#Preview {
////    RecommendedBooksView()
////}
