//
//  ContentView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 27/5/25.
//

import SwiftUI

struct ArtObjectsListView: View {
    
    @State var model: ArtObjectViewModel
    
    var body: some View {
        NavigationStack {
            ZStack{
                if model.isLoading {
                    ProgressView("Cargando obras...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        if model.artObjects.isEmpty && !model.text.isEmpty {
                            Text("No se encontraron resultados para \"\(model.text)\"")
                                .foregroundColor(.secondary)
                                .padding()
                        } else {
                            ForEach(model.artObjects) { artObject in
                                ArtObjectRow(artObject: artObject)
                            }
                        }
                    }
                    .navigationTitle("Art objects")
                    .searchable(
                        text: $model.text,
                        prompt: "Buscar obra"
                    )
                }
                
                if model.isSearching {
                    VStack {
                        ProgressView("Buscando obras...")
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
            }
            .task {
                await model.getMaxArtObjects(max: 50)
            }
            .alert("App Service Error", isPresented: $model.isAlertPresented) {} message: {
                Text(model.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    ArtObjectsListView(model: .init(network: NetworkTest()))
}
