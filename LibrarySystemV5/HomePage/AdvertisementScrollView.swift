//
//  AdvertisementScrollView.swift
//  LibrarySystem
//
//  Created by YunXian Xu on 2025-03-02.
//

import SwiftUI

struct AdvertisementScrollView: View {
    let adImages = ["ad1", "ad2", "ad3"]
    
    var body: some View {
        TabView {
            ForEach(adImages, id: \.self) { imgName in
                Image(imgName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 150, alignment: .center)
    }
}

// Preview
struct AdvertisementScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementScrollView()
    }
}
