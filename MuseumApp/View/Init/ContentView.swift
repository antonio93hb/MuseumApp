//
//  ContentView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            Tab("Art's Day", systemImage: "bookmark") {
                ArtOfTheDayView(model: .init())
            }
            Tab("List", systemImage: "list.bullet") {
                ArtObjectsListView(model: .init())
            }
            Tab("Cards", systemImage: "person.text.rectangle") {
                CardsView(model: .init())
            }
            Tab("Visit", systemImage: "map") {
                VisitView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
        .environment(RootManager())
}
