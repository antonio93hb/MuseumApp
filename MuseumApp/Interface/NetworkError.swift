//Gestiona los errores de conexión

import Foundation

enum NetworkError: LocalizedError {
    case nonHTTP
    case general(Error)
    case status(Int)
    case json(Error)
    
    var errorDescription: String? {
        switch self {
        case .nonHTTP:
            return String(localized: "No se trató de una respuesta HTTP")
        case .general(let error):
            return String(localized: "General: \(error.localizedDescription)")
        case .status(let code):
            return String(localized: "Error de status: \(code)")
        case .json(let error):
            return String(localized: "JSON: \(error.localizedDescription)")
        }
    }
}
