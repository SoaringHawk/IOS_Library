//
//  SaleBookScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-28.
//

import SwiftUI

struct SaleBookScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                //img part
                Image("BookSale")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .white.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .clipped()
                
                
                Text("LIBRARY POP-UP")
                    .font(.system(size: 28, weight: .light))
                    .kerning(4)
                    .padding(.top, 30)
                
                Text("BOOK SALE")
                    .font(.system(size: 36, weight: .bold))
                    .padding(.bottom, 10)
                
                Text("50% OFF")
                    .font(.system(size: 24, weight: .medium))
                    .padding(.horizontal, 25)
                    .padding(.vertical, 8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)

                //time and location
                VStack(spacing: 25) {
                    HStack(spacing: 15) {
                        Text("📅")
                            .font(.system(size: 22))
                        Text("May 15-17 · 10AM-6PM")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    
                    HStack(spacing: 15) {
                        Text("📍")
                            .font(.system(size: 22))
                        Text("1F Main Lobby")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .padding(.vertical, 30)
                
                //require
                VStack(alignment: .leading, spacing: 15) {
                    Text("NOTES")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                    
                    Divider()
                    
                    NoteItem(text: "Cash only")
                    NoteItem(text: "Please bring your own reusable bag")
                    NoteItem(text: "No ID or library card required")
                }
                .padding(25)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .padding(20)
                
                Text("📖  Every book deserves a second chapter")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
                Text("🌱  Find your destined story")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.top) //push img to the top
        .background(Color.white)
    }
}


struct NoteItem: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .frame(width: 6, height: 6)
                .padding(.top, 6)
            
            Text(text)
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}


#Preview {
    SaleBookScreen()
}
