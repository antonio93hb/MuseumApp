//
//  ArtObjectDetailView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 1/6/25.
//

import SwiftUI


struct ArtObjectDetailView: View {
    let artObject: ArtObjectModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                ImageView(artObject: artObject)
                
                Text(artObject.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Artista: \(artObject.artist)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Fecha: \(artObject.date)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArtObjectDetailView(artObject: .test)
}
