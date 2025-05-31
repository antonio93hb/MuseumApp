//
//  ArtObject.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 27/5/25.
//

import Foundation

struct ArtObjectModel: Identifiable, Hashable {
    let id: Int // Será el objectID del DTO
    let title: String
    let artist: String
    let date: String
    let imageUrl: String
    let department: String
    let culture: String
    let medium: String
    let dimensions: String
    let objectUrl: String
}
