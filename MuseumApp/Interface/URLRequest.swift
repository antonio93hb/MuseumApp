// Es una clase que realmente no nos es necesaria ahora mismo, ya que todas las peticiones serán GET y no es necesario usar la URLRequest, aun así vamos a hacer unas comprobaciones y otros métodos, como que no tarde más de 10 segundos en cargar o asegurarse que es una petición GET lo que se está haciendo. Por otro lado con el setValue le diremos que es un JSON lo que vamos a recibir y no un zip o un xml por ejemplo.

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

extension URLRequest {
    static func get (_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = HTTPMethod.get.rawValue //Aunque lo sea por defecto, lo volvemos a comprobar
        request.setValue("aplication/json", forHTTPHeaderField: "Accept")
        return request
    }
}
