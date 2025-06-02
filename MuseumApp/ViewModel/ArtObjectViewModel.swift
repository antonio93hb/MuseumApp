

import SwiftUI

@MainActor
@Observable
final class ArtObjectViewModel {
    let network: DataRepository
    
    // MARK: Objeto
    var artObjects: [ArtObjectModel] = []
    var artObject: ArtObjectModel?
    
    // MARK: Alerta
    var isAlertPresented = false
    var errorMessage: String?
    
    // MARK: Estado
    var isSearching = false
    var isPaginating = false

    // MARK: Búsqueda
    private var lastSearchText = ""
    var text = "" {
        didSet {
            if text != lastSearchText {
                lastSearchText = text
                Task {
                    print("AHB: Texto cambiado a \(text)")
                    await search()
                }
            }
        }
    }
    var searchTask: Task<Void, Error>?
    
    // MARK: Paginación
    var currentPage = 0
    var pageSize = 10
    var hasMorePages = true

    // MARK: Init
    init(network: DataRepository = NetworkRepository()) {
        self.network = network
    }
    
    // MARK: Métodos
    private func search() async {
        if searchTask != nil {
            searchTask?.cancel()
            searchTask = nil
        }
        
        searchTask = Task {
            try await Task.sleep(for: .seconds(0.3))
            if !Task.isCancelled {
                await startSearch()
            }
        }
    }
}

extension ArtObjectViewModel {
    
    func startSearch() async {
        isSearching = true
        defer { isSearching = false }

        currentPage = 0
        artObjects = []
        
        await loadNextPage()
    }
    
    func loadNextPage() async {
        guard !isPaginating, hasMorePages else { return }
        
        isPaginating = true
        defer { isPaginating = false }
        
        let offset = currentPage * pageSize
        
        do {
            let newItems = try await network.getPaginatedArtObjects(
                offset: offset,
                limit: pageSize,
                query: text
            )
            
            if newItems.isEmpty {
                hasMorePages = false
                return
            }
            
            artObjects.append(contentsOf: newItems)
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
            isAlertPresented = true
        }
    }
}
extension ArtObjectViewModel {
    func getRandomArtObject() async {
        do {
            let randomArtObject = try await network.getRandomArtObject()
            self.artObjects = randomArtObject
        } catch {
            errorMessage = error.localizedDescription
            isAlertPresented = true
        }
    }
}
