//
//  NetworkTest.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 29/5/25.
//

import Foundation

struct NetworkTest: DataRepository {
    func getSearchArtObjects(max: Int, query: String) async throws -> [ArtObjectModel] {
        try getJSON(fileName: "ArtObjectsPreview", type: [ArtObjectDetailDTO].self)
            .filter({$0.title.lowercased().contains(query.lowercased())})
            .compactMap(\.toArtObjectModel)
    }
    
    func getMaxArtObjects(max: Int) async throws -> [ArtObjectModel] {
        try getJSON(fileName: "ArtObjectsPreview", type: [ArtObjectDetailDTO].self)
            .compactMap(\.toArtObjectModel)
    }
    
    private func getJSON<JSON>(fileName: String, type: JSON.Type) throws -> JSON where JSON: Decodable {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(JSON.self, from: data)
    }
    
}
