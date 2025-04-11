//
//  SplashScreen.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 09/04/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var opacity = 0.0  // 用于淡入效果

    var body: some View {
        if isActive {
            ContentView() // main app view
        } else {
            ZStack{
                Color(red: 0.98, green: 0.96, blue: 0.90)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("booklogo") // logo image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .opacity(opacity)
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(0.6)
                    Text("Library Lasalle")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(0.6)
                    
                }
                .onAppear {
                    //opacity animate
                    withAnimation(.easeIn(duration: 1.0)) {
                        opacity = 1.0
                    }
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
