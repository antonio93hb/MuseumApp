import Foundation

protocol DataRepository {
    func getPaginatedArtObjects(offset: Int, limit: Int, query: String?) async throws -> [ArtObjectModel]
    func getRandomArtObject() async throws -> [ArtObjectModel] 
}
