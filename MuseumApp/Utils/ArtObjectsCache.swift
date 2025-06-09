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
        self.ids = ids
        currentIndex = 0
    }
    
    func getIds(count: Int, getFirsts: Bool = true) -> [Int] {
        guard !ids.isEmpty else { return [] }
        
        if getFirsts {
            currentIndex = 0
        }
        
        let startIndex = currentIndex
        let endIndex = min(currentIndex + count, ids.count)
        
        if startIndex >= endIndex { return [] }
        let result = Array(ids[startIndex..<endIndex])
        return result
    }
}
