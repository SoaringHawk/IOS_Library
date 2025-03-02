//
//  HomeView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-01.
//

import SwiftUI



struct HomeView: View {
    let books = [
        "GoneWithTheWind",
        "LittleWomen",
        "PrideAndPrejudice",
        "The Handmaid's Tale",
        "TheLittlePrince"
    ]

    @State private var currentBooks: [String] = []
    @State private var showLogin = false

    var body: some View {
        VStack {
            // 搜索栏和登录按钮
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

            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(["Fiction", "Mystery", "History", "Economic", "Psychology"], id: \.self) { category in
                        Text(category)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()

            
            VStack(alignment: .leading) {
                Text("Recommand for you")
                    .font(.title)
                    .padding(.leading)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(currentBooks, id: \.self) { book in
                            VStack {
                                Image(book)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(8)
                                Text(book)
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading)
                        }
                    }
                }
            }

       
            Button("Explore More") {
                
                currentBooks = books.shuffled()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .onAppear {
           
                currentBooks = Array(books.prefix(3))
            }
        }.padding(.top)  
    }
        

    @State private var searchText = ""
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




#Preview {
    HomeView()
}
