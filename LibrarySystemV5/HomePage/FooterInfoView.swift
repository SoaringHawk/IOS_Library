//
//  FooterInfoView.swift
//  LibrarySystemV5
//
//  Created by YunXian Xu on 2025-04-11.
//

import SwiftUI

struct FooterInfoView: View {
    var body: some View {
        VStack(spacing: 16) {
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
//                Text("LIBRARY INFORMATION")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                    .padding(.bottom, 4)
                
                Text("Open: Tue-Sun 9AM-8PM")
                Text("0911 Bibulibabulibu Street, H3G0G1")
                Text("Email: Library@gmail.com")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("© 2025 Library System - Capybaras Inc.")
                .font(.caption2)
                .foregroundColor(.gray)
                
        }
        .padding()
        .background(Color(.systemBackground))
    }
}



#Preview {
    FooterInfoView()
}
