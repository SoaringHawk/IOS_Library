//
//  KidBookScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-28.
//

import SwiftUI


struct KidBookScreen: View {
    //turning the animation on or off
    @State private var isPulsing = false
    
    var body: some View {
        ScrollView{
            ZStack {
                //background color
                //Color(red: 0.98, green: 0.96, blue:0.89)
                   // .edgesIgnoringSafeArea(.all)
                //Background color move to the bottom with scroll view
                
                VStack(spacing:20) {
                    VStack{
                        Text("APRIL 28")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        Text("2025")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.brown)
                    .padding(.top, 40) // leave the space for Dynamic island on the top
                    
                    //Main title
                    VStack(spacing: 10) {
                        Text("Less iPad, More Books")
                            .font(.system(size: 28, weight: .heavy, design: .serif))
                            .foregroundColor(.black)
                        Text("Discover our new book collection in Basement Level 1 for children!")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    //round center image
                    Image("LibraryKid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 170)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                        .contentShape(Circle())
                        //.font(.system(size: 50))
                        //.foregroundColor(.orange)
                        .scaleEffect(isPulsing ? 1.1 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.5).repeatForever(),
                            value: isPulsing
                        )
                        .onAppear { isPulsing = true }
                        .padding(.top, 10)
                    
                    
                    Text("Bring your kids to explore the joy of reading.")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .italic()
                        .foregroundColor(.black.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6) //if it too long then minimum the world
                        .padding(.horizontal, 30)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        DetailItemView(
                            icon: "books.vertical.fill",
                            title: "Expanded Kids Area",
                            description: "We've doubled the children's reading space with cozy seating!"
                        )
                        DetailItemView(
                            icon: "plus.circle.fill",
                            title: "500+ New Books",
                            description: "Picture books, STEM kits, and interactive stories added."
                        )
                        DetailItemView(
                            icon: "calendar.badge.clock",
                            title: "Longer Borrow Time",
                            description: "Kids can now borrow books for 4 weeks."
                        )
                        
                    }
                    .padding(.horizontal,20)
                    
                    //bottom part
                    VStack {
                        Text("Basement 1st - No reservation needed")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        
                        Text("Open daily 9AM-7PM")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue.opacity(0.8))
                            .padding(.top, 5)
                    }
                    .padding(.top, 20)
            
                    
                }
                .padding()
            }
        }
        .background(Color(red: 0.98, green: 0.96, blue: 0.89))
        .edgesIgnoringSafeArea(.all)



    }
}
//
//struct DetailItem: View {
//    let icon: String
//    let title: String
//    let description: String
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 12) {
//            Image(systemName: icon)
//                .font(.system(size: 22))
//                .foregroundColor(.orange)
//                .frame(width: 30)
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.system(size: 18, weight: .semibold))
//                    .foregroundColor(.black)
//                
//                Text(description)
//                    .font(.system(size: 15))
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}


#Preview {
    KidBookScreen()
}
