//
//  DetailItemView.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-03-29.
//

import SwiftUI


struct DetailItemView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.orange)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
        }
    }
}


//
//#Preview {
//    DetailItemView()
//}


struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView(icon: "books.vertical.fill", title: "Sample", description: "This is a sample ")
    }
}
