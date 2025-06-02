//
//  WellcomeView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//


import SwiftUI

struct WellcomeView: View {
    @State private var showContentView = false
    
    var body: some View {
        if showContentView {
            ContentView()
        } else {
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
                    showContentView.toggle()
                } label: {
                    Text("Empezar")
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
        }
    }
}

#Preview {
    WellcomeView()
}
