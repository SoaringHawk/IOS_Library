//
//  SplashScreen.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView() // main app view
        } else {
            ZStack{
                Color.mint
                    .ignoresSafeArea()
                
                VStack {
                    Image("booklogo") // logo image
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("Library Lasalle")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(0.6)
                    
                }
                
                
                .onAppear {
                    // Delay for 2 seconds then show main content
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
                
            }
            
            
        }
    }
        
        
}

#Preview {
    SplashScreen()
}
