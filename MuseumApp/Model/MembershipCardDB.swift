//
//  MembershipCardDB.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 4/6/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class MembershipCardDB {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var membership: MembershipType
    var qrCode: Data
    
    init(id: UUID = .init(), name: String, email: String, membership: MembershipType, qrCode: Data) {
        self.id = id
        self.name = name
        self.email = email
        self.membership = membership
        self.qrCode = qrCode
    }
    
    // Computed property para mostrar el QR como Image en la UI
    var qrCodeImage: Image {
        if let uiImage = UIImage(data: qrCode) {
            return Image(uiImage: uiImage)
                .interpolation(.none)
                .resizable()
        } else {
            return Image(systemName: "xmark.circle")
        }
    }
}

enum MembershipType: String, Codable, CaseIterable {
    case adult = "Adult"
    case student = "Student"
    case senior = "Senior"
    case junior = "Junior"
    
    var color: Color {
        switch self {
        case .adult: return .blue
        case .student: return .yellow
        case .senior: return .orange
        case .junior: return .mint
        }
    }
}
