import Foundation

protocol DataRepository {
    func getPaginatedArtObjects(offset: Int, limit: Int, query: String?) async throws -> [ArtObjectModel]
}
