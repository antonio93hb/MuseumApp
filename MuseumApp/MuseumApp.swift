//
//  MuseumAppApp.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 27/5/25.
//

import SwiftUI
import SwiftData

@main
struct MuseumApp: App {
    @State private var rootManager = RootManager()
    
    var sharedModelContainer: ModelContainer {
        
        let schema = Schema([MembershipCardDB.self])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("No se pudo crear el model container: \(error)")
        }
    }

    
    var body: some Scene {
        WindowGroup {
            //            WellcomeView()
            RootView()
                .environment(rootManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
