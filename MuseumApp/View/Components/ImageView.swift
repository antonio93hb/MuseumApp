//
//  ImageView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 29/5/25.
//

import SwiftUI

struct ImageView: View {
    
    let artObject: ArtObjectModel
    
    var body: some View {
        
        if let url = URL(string: artObject.imageUrl), !artObject.imageUrl.isEmpty {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 4, y: 4)
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.4), radius: 4, x: 4, y: 4)
        }
    }
}

#Preview {
    List{
        ImageView(artObject: .test)
    }
}
