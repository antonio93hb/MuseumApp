import Foundation

protocol DataRepository {
    func getMaxArtObjects(max: Int) async throws -> [ArtObjectModel]
    func getSearchArtObjects(max: Int, query: String) async throws -> [ArtObjectModel]
}
