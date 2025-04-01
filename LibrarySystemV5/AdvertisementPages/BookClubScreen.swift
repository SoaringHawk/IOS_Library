//
//  BookClubScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-28.
//

import SwiftUI

struct BookClubScreen: View {
    // 活动数据

    let hoster = "Jerry"
    let currentBook = "Three Body Problem"
    let author = "Cixing Liu"
    let startDate = "May 1"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("BookClub")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .mask(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .white]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .blur(radius: 1) // 模糊强度
                    .overlay(
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("JOIN OUR BOOK CLUB")
                                .font(.system(size: 32, weight: .black))
                                .kerning(2)
                        }
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //leading - text to the left
                    )
                

                Text("Insights Beyond Paperbacks")
                    .font(.system(size: 18, weight: .medium, design: .serif))
                    .italic()
                    .foregroundColor(.gray.opacity(0.8))
                
                
                VStack(spacing: 4) {
                    Text("Moderated by")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                    
                    Text(hoster)
                        .font(.title2.weight(.bold))
                    
                    Text("Discover the universe's wonders with us")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(spacing: 5) {
                    Text("Currently Reading")
                        .font(.headline.weight(.semibold))
                        .padding(.top, 25)
                    
                    Text(currentBook )
                        .font(.title2.weight(.bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                    
                    Text("by \(author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal) //Set horizontal padding so that the content does not display against the edge/
                
 
                Image("ThreeBodyProblem")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200, height:200)
                    .padding(.top, 20)
                    
                
                VStack(alignment: .leading, spacing: 15) {
                    DetailItemView(
                        icon: "person.fill.badge.plus",
                        title: "How to register",
                        description: "Library 1st floor register with front desk"
                    )
                    DetailItemView(
                        icon: "list.bullet.rectangle.portrait",
                        title: "What you need to prepare",
                        description: "Current Book, ID, library card"
                    )
                    DetailItemView(
                        icon: "calendar",
                        title: "Book club time",
                        description: "May 1, 15:00-18:00. 4th Floor Conference Room"
                    )
                    
                }.padding(.top, 30)
                Color.clear.frame(height: 30)
            }
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.top)
    }
}



#Preview {
    BookClubScreen()
}

