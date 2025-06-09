//
//  RootView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 3/6/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(RootManager.self) var rootManager

    var body: some View {
        switch rootManager.currentView {
        case .welcome: WelcomeView(model: .init())
        case .login: LoginView()
        case .content: ContentView()
        }
    }
}
