//
//  ArtDayView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//

import SwiftUI

struct ArtOfTheDayView: View {
    
    @State var model: ArtObjectViewModel
//    @State private var goToFormView = false
    
    var body: some View {

        NavigationStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(radius: 10)
                .padding()

            
            VStack(alignment: .leading) {
                
                // Título
                Text("Obras del día")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
                    .padding(.top)
                    .padding(.horizontal)
                
                Text("Descubre una selección diaria del MET")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Scroll horizontal con imágenes
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(model.artObjects) { artObject in
                            NavigationLink(
                                destination: ArtObjectDetailView(artObject: artObject)
                            ) {
                                ImageView(artObject: artObject)
                                    .frame(width: 160, height: 160)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(radius: 4)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Cita
                Text("“Art is what you can get away with.” -\nAndy Warhol")
                    .font(.body)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)

            }
            .task {
                await model.getRandomArtObject()
            }
        }
    }
}

#Preview {
    ArtOfTheDayView(model: .init(network: NetworkTest()))
}
