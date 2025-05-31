//
//  ArtObjectRow.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 29/5/25.
//

import SwiftUI

struct ArtObjectRow: View {
    
    let artObject: ArtObjectModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(artObject.title)
                    .font(.headline)
                Text(artObject.artist)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(artObject.date)
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                    .padding(.top)
            }
            Spacer()
            ImageView(artObject: artObject)
        }
    }
}

#Preview {
    List {
        ArtObjectRow(artObject: .test)
    }
}

