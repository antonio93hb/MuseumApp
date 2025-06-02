//
//  ArtDayView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//

import SwiftUI

struct ArtOfTheDayView: View {
    
    @State var model: ArtObjectViewModel
    @State private var goToFormView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
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
                
                
                // Botón "Hazte socio"
                Button(action: {
                    goToFormView = true
                }) {
                    Text("Hazte socio")
                        .font(.headline)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .stroke(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                        )
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
            }
            .task {
                await model.getRandomArtObject()
            }
            .navigationDestination(isPresented: $goToFormView) {
                FormView()
            }
        }
    }
}

#Preview {
    ArtOfTheDayView(model: .init(network: NetworkTest()))
}
