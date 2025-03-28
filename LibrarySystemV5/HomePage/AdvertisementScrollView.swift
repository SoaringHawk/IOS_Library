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
        NavigationView {
            TabView {
                ForEach(adImages, id: \.self) { imgName in
                    NavigationLink(destination: destinationView(for: imgName)) {
                        Image(imgName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .clipped()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 200)
        }
    }
    
    @ViewBuilder
    private func destinationView(for imgName: String) -> some View {
        switch imgName {
        case "ad1":
            SaleBookScreen()
        case "ad2":
            BookClubScreen()
        case "ad3":
            KidBookScreen()
        default:
            Text("Unknown Advertisement - please call technical support")
        }
    }
}

struct AdvertisementScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementScrollView()
    }
}
