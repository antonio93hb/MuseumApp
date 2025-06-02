//
//  NetworkTest.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 29/5/25.
//

import Foundation

struct NetworkTest: DataRepository {
    func getPaginatedArtObjects(offset: Int, limit: Int, query: String?) async throws -> [ArtObjectModel] {
        // Cargar todos los datos desde el JSON local
        let allObjects = try getJSON(fileName: "ArtObjectsPreview", type: [ArtObjectDetailDTO].self)
            .compactMap(\.toArtObjectModel)
        
        // Filtrado si hay texto de búsqueda
        let filtered = if let query = query, !query.isEmpty {
            allObjects.filter { $0.title.lowercased().contains(query.lowercased()) }
        } else {
            allObjects
        }
        
        // Simulación de paginación
        let paginated = filtered.dropFirst(offset).prefix(limit)
        print("AHB: Filtrando con query: \(query ?? "nil")")
        print("AHB: Resultados: \(filtered.count)")
        return Array(paginated)
    }
    func getRandomArtObject() async throws -> [ArtObjectModel] {
        let allObjects = try getJSON(fileName: "ArtObjectsPreview", type: [ArtObjectDetailDTO].self)
            .compactMap(\.toArtObjectModel)
            .filter { !$0.imageUrl.isEmpty } // solo con imagen

        // Devolver hasta 5 aleatorios con imagen
        return Array(allObjects.shuffled().prefix(5))
    }
    
    private func getJSON<JSON>(fileName: String, type: JSON.Type) throws -> JSON where JSON: Decodable {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(JSON.self, from: data)
    }
}
