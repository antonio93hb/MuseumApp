//
//  WellcomeView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//


import SwiftUI

struct WelcomeView: View {
    @Environment(RootManager.self) var rootManager
    @State var model: ArtObjectViewModel
    
    var body: some View {

            VStack {
                Image(systemName: "building.columns")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .bold()
                    .padding()
                
                Text("Bienvenido al MET")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .bold()
                
                Text("Explora arte, historia y cultura del MET. Descubre obras únicas, artistas, épocas y mucho más.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button{
                    rootManager.currentView = .login
                } label: {
                    Text("Login")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top,80)
                        .padding()
                }
                
                Text("Desarrollado con la API del MET")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
            }
            .onAppear {
                Task {
                    await model.loadNextPage()
                }
            }
    }
}

#Preview {
    WelcomeView(model: .init(network: NetworkTest()))
        .environment(RootManager())
}
