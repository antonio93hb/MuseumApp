//Une la interfaz con la red. E

import Foundation

struct NetworkRepository: DataRepository, NetworkInteractor {

    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    //MARK: Privados

    private func getAllObjectsId() async throws -> [Int] {
        return try await getJSON(request: .get(.getAllObjects), type: ArtObjectsDTO.self)
            .objectIDs ?? []
    }
    
    private func getObject(id: Int) async throws -> ArtObjectModel {
        return try await getJSON(request: .get(.getObject(id)), type: ArtObjectDetailDTO.self)
            .toArtObjectModel
    }
    
    private func searchIdsObjects(query: String) async throws -> [Int] {

        let result = try await getJSON(request: .get(.searchObjects(query: query)), type: ArtObjectsDTO.self)
        guard let ids = result.objectIDs else {
            return []
        }
        return ids
    }
}

//MARK: Públicos

extension NetworkRepository {
    func getPaginatedArtObjects(offset: Int, limit: Int, query: String?) async throws -> [ArtObjectModel] {
        
        let ids: [Int]
        var artObjects: [ArtObjectModel] = []
        
        if let query, !query.isEmpty {
            ids = try await searchIdsObjects(query: query)
        } else {
            ids = try await getAllObjectsId()
        }
        
        guard !ids.isEmpty else { return [] }
        
        let paginatedIDs = ids.dropFirst(offset).prefix(limit)
        
        
        for id in paginatedIDs {
            if let object = try? await getObject(id: id) {
                artObjects.append(object)
            }
        }
        return artObjects
    }
}
