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
                List {
                    if model.artObjects.isEmpty && !model.text.isEmpty && !model.isSearching && !model.isPaginating {
                        Text("No se encontraron resultados para \"\(model.text)\"")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ForEach(model.artObjects) { artObject in
                            NavigationLink(
                                destination: ArtObjectDetailView(artObject: artObject)
                            ) {
                                ArtObjectRow(artObject: artObject)
                                    .onAppear {
                                        if artObject == model.artObjects.last {
                                            Task {
                                                await model.loadNextPage()
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Art objects")
                .searchable(
                    text: $model.text,
                    prompt: "Buscar obra"
                )
                
                if model.isSearching || model.isPaginating {
                    VStack {
                        ProgressView("Cargando obras...")
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
            }
            .task {
                await model.startSearch()
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
