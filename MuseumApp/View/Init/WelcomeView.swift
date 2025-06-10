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
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .bold()
                    .padding()
                
                Text("Welcome to the MET")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .bold()
                
                Text("Explore art, history, and culture at the MET. Discover unique artworks, artists, eras, and much more.")
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
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top,80)
                        .padding()
                }
                
                Text("*Developed with the **MET API***")
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
