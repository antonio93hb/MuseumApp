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
        
        var artObjects: [ArtObjectModel] = []
        
        if let query, !query.isEmpty {
            let ids = try await searchIdsObjects(query: query)
            let paginatedIDs = ids.dropFirst(offset).prefix(limit)
            
            try await withThrowingTaskGroup(of: ArtObjectModel?.self) { group in
                
                for id in paginatedIDs {
                    group.addTask {
                        try? await getObject(id: id)
                    }
                }
                
                for try await object in group {
                    if let object = object {
                        artObjects.append(object)
                    }
                }
            }
            return artObjects
        }
        
        if ArtObjectsCache.shared.ids.isEmpty {
            let ids = try await getAllObjectsId()
            ArtObjectsCache.shared.store(ids: ids)
        }

        let getFirsts = offset == 0
        let paginatedIDs = ArtObjectsCache.shared.getIds(count: limit, getFirsts: getFirsts)
        
        try await withThrowingTaskGroup(of: ArtObjectModel?.self) { group in
            for id in paginatedIDs {
                group.addTask {
                    try? await self.getObject(id: id)
                }
            }
            
            for try await object in group {
                if let object {
                    artObjects.append(object)
                }
            }
        }
        return artObjects
    }
    
    func getRandomArtObject() async throws -> [ArtObjectModel] {
        var artObjects: [ArtObjectModel] = []
        
        while artObjects.count < 5 {
            let randomID = Int.random(in: 1...100_000)
            
            if let object = try? await getObject(id: randomID), !object.imageUrl.isEmpty {
                artObjects.append(object)
            }
        }
        return artObjects
    }
}
