//
//  BookDetails.swift
//  LibrarySystemV2
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI

struct BookDetails: View {
    
    var body: some View {
        
            VStack {
                
                Image("etranger")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
                Text("The fire of the lord")
                    .font(.title)
                    .padding(.bottom)
                
                Text("L'Étranger (The Stranger) by Albert Camus is a 1942 existentialist novel set in French Algeria. It follows Meursault, an emotionally detached French Algerian who fails to show conventional grief at his mother's funeral. Later, he kills an Arab man on a beach seemingly without clear motivation or remorse. During his trial, he's condemned not just for the murder but for his indifference toward his mother's death and social norms. The novel explores themes of absurdism, alienation from society, and the meaninglessness of life.")
                    .font(.subheadline)
                    .padding(.bottom, 80
                    )
                
                Button(action: {
                                
                            }) {
                                Text("Rent this book")
                                    .font(.title)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
            }
            .padding(.leading)
        
    }
}

#Preview {
    BookDetails()
}
