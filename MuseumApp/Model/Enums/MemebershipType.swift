//
//  MemebershipType.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 6/6/25.
//

import SwiftUI

enum MembershipType: String, Codable, CaseIterable {
    case adult = "Adult"
    case student = "Student"
    case senior = "Senior"
    case junior = "Junior"
    
    var color: Color {
        switch self {
        case .adult: return .red
        case .student: return .yellow
        case .senior: return .blue
        case .junior: return .mint
        }
    }
}
