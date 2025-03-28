//
//  BookClubScreen.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-28.
//

import SwiftUI

struct BookClubScreen: View {
    var body: some View {
        ZStack {
            // 背景色（浅黄色，类似纸质）
            Color(red: 0.98, green: 0.96, blue: 0.89)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // 顶部日期
                VStack {
                    Text("APRIL 28")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("2025")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.brown)
                
                // 主标语
                VStack(spacing: 10) {
                    Text("Less iPad, More Books!")
                        .font(.system(size: 28, weight: .heavy, design: .serif))
                        .foregroundColor(.black)
                    
                    Text("Discover our new book collection in Basement Level 1!")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                // 装饰性图标
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                    .padding(.top, 10)
                
                // 副标语
                Text("Bring your kids to explore the joy of reading.")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .italic()
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.horizontal, 30)
                
                // 底部链接风格文本
                VStack {
                    Text("Library Reading Week")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                    
                    Text("www.ourlibrary.com/newbooks")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                        .underline()
                
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    BookClubScreen()
}
