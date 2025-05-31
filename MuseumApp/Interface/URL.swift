//Hacemos extensión de la url para la construcción de rutas de URL

import Foundation

extension URL {
    // https://collectionapi.metmuseum.org/public/collection/v1/objects
    
    static var getAllObjects: URL {
        createURL(path: "/public/collection/v1/objects")
    }
    
    // https://collectionapi.metmuseum.org/public/collection/v1/departments
    
    static var getDepartments: URL {
        createURL(path: "/public/collection/v1/departments")
    }
    
    // https://collectionapi.metmuseum.org/public/collection/v1/objects/[objectID]
    
    static func getObject(_ id: Int) -> URL {
        createURL(path: "/public/collection/v1/objects/\(id)")
    }
    
    // https://collectionapi.metmuseum.org/public/collection/v1/search
    
    static func searchObjects(query: String) -> URL {
        let queryItems = [URLQueryItem(name: "q", value: query)]
        
        print("AHB: \(createURL(path: "/public/collection/v1/search", queryItems: queryItems))")
        return createURL(path: "/public/collection/v1/search", queryItems: queryItems)
    }

    
    private static func createURL(path: String, queryItems: [URLQueryItem]? = nil) -> URL {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "collectionapi.metmuseum.org"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            fatalError("URL creation failed")
        }
        
        return url
    }
}
