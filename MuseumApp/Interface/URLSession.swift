// Será el servicio, los helpers que necesitaremos, una extensión para oeticiones de red. Así ecapsulamos la lógica de red para evitar repetir código en cada llamada. Lo haremos tanto from URL, como for URLRQUEST. Esto es por si necesitamos usar peticiones PUT, DELETE o UPDATE. Realmente esta app solo hará peticiones GET, por lo que no sería necesario el URLRequest

import Foundation

extension URLSession {
    
    func getData(from url: URL) async throws(NetworkError) -> (
        data: Data,
        response: HTTPURLResponse
    ) {
        do {
            let (data, response) = try await data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .general(error)
        }
    }
    
    func getData(for request: URLRequest) async throws(NetworkError) -> (
        data: Data,
        response: HTTPURLResponse
    ) {
        do {
            let (data, response) = try await data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .general(error)
        }
    }
}
