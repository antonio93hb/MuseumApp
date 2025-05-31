//
//  ArtObjectsDTO.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 28/5/25.
//

import Foundation

struct ArtObjectsDTO: Codable {
    let total: Int
    let objectIDs: [Int]?
}
