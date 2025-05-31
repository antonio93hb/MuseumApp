

import SwiftUI

@Observable
final class ArtObjectViewModel {
    let network: DataRepository
    
    var artObjects: [ArtObjectModel] = []
    var artObject: ArtObjectModel?
    
    var isAlertPresented = false
    var errorMessage: String?
    
    var isLoading = true
    var isSearching = false

    private var lastSearchText = ""
    
    var text = "" {
        didSet {
            if text != lastSearchText {
                lastSearchText = text
                Task {
                    await search()
                }
            }
        }
    }
    
    var searchTask: Task<Void, Error>?
    
    init(network: DataRepository = NetworkRepository()) {
        self.network = network
    }
    
    func search() async {
        if searchTask != nil {
            searchTask?.cancel()
            searchTask = nil
        }
        
        searchTask = Task {
            try await Task.sleep(for: .seconds(0.4))
            if !Task.isCancelled {
                await getSearchArtObjects(max: 10)
            }
        }
    }
    
    func getMaxArtObjects(max: Int) async {
        defer { isLoading = false }
        do {
            artObjects = try await network.getMaxArtObjects(max: max)
        } catch {
            errorMessage = error.localizedDescription
            isAlertPresented = true
        }
    }
    
    func getSearchArtObjects(max: Int) async {
        print("AHB: Se ha llamado")
        isSearching = true
        defer { isSearching = false }
        do {
            if text.isEmpty {
                artObjects = try await network.getMaxArtObjects(max: max)
            } else {
                artObjects = try await network.getSearchArtObjects(max: max, query: text)
            }
        } catch {
            errorMessage = error.localizedDescription
            isAlertPresented = true
        }
    }
}
