// Es la capa que tiene la lógica de necocio de red. Hemos creado el protocolo para mayor abstracción y lo hacemos de tipo genérico para poder reusarlo

import Foundation

protocol NetworkInteractor {
    var session: URLSession { get }
}

extension NetworkInteractor {
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
        let (data, response) = try await session.getData(for: request)
        guard response.statusCode == 200 else {
            throw .status(response.statusCode)
        }
        do {
            return try JSONDecoder().decode(JSON.self, from: data)
        } catch {
            throw .json(error)
        }
    }
}
