//
//  RootManager.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 3/6/25.
//

import Foundation

@Observable
final class RootManager {
    
    enum Views {
        case welcome
        case login
        case content
    }
    var currentView: Views = .welcome
}

