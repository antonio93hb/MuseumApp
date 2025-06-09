//
//  ArtObjectsCache.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 6/6/25.
//

import Foundation

final class ArtObjectsCache {
    static let shared = ArtObjectsCache()
    
    private(set) var ids: [Int] = []
    private var currentIndex = 0
    
    private init() {}
    
    func store(ids: [Int]) {
        guard self.ids.isEmpty else {
            print("AHB: La cache ya está cargada con \(self.ids.count) IDs, no se sobrescribe")
            return
        }
        self.ids = ids
        currentIndex = 0
        print("AHB: Cache inicializada con \(ids.count) IDs")
    }
    
    func getIds(count: Int, getFirsts: Bool = true) -> [Int] {
        guard !ids.isEmpty else { return [] }
        
        if getFirsts {
            currentIndex = 0
        }
        
        let startIndex = currentIndex
        let endIndex = min(currentIndex + count, ids.count)
        
        if startIndex >= endIndex { return [] }
        currentIndex = endIndex
        let result = Array(ids[startIndex..<endIndex])
        print("AHB: Devueltos IDs del \(startIndex) al \(endIndex), total: \(result.count)")
        return result
    }
}
