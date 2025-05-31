//Une la interfaz con la red. E

import Foundation

struct NetworkRepository: DataRepository, NetworkInteractor {

    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func getAllObjectsId() async throws -> [Int] {
        return try await getJSON(request: .get(.getAllObjects), type: ArtObjectsDTO.self)
            .objectIDs ?? []
    }
    
    private func getObject(id: Int) async throws -> ArtObjectModel {
        return try await getJSON(request: .get(.getObject(id)), type: ArtObjectDetailDTO.self)
            .toArtObjectModel
    }
    
    func getMaxArtObjects(max: Int) async throws -> [ArtObjectModel] {
        let ids = try await getAllObjectsId().prefix(max)
        
        var result: [ArtObjectModel] = []
        for id in ids {
            result.append(try await getObject(id: id))
        }
        return result
    }
    
    //MARK: Search
    private func searchIdsObjects(query: String) async throws -> [Int] {

        let result = try await getJSON(request: .get(.searchObjects(query: query)), type: ArtObjectsDTO.self)
            
        guard let ids = result.objectIDs else {
            print("AHB: No se encontraron resultados para \"\(query)\"")
            return []
        }
        print("AHB: Devuelve este número de objetos: \(ids.count)")

        return ids
    }
    
    func getSearchArtObjects(max: Int, query: String) async throws -> [ArtObjectModel] {
        let ids = try await searchIdsObjects(query: query).prefix(max)
        guard !ids.isEmpty else { return [] }
        var result: [ArtObjectModel] = []

        for id in ids {
            if let object = try? await getObject(id: id) {
                result.append(object)
            }
        }
        return result
    }
    
}
