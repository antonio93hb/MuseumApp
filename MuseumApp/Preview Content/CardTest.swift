//
//  CardTest.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 4/6/25.
//

import Foundation
import SwiftUI

extension MembershipCardDB {
    static var sampleQRCodeData: Data {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        if let image = UIImage(systemName: "qrcode", withConfiguration: config) {
            return image.pngData() ?? Data()
        }
        return Data()
    }
}

extension MembershipCardDB {
    static var preview: MembershipCardDB {
        MembershipCardDB(
            id: UUID(),
            name: "Antonio",
            email: "antonio@example.com",
            membership: .adult,
            qrCode: sampleQRCodeData
        )
    }
}

extension MembershipCardDB {
    static var dummyCards: [MembershipCardDB] {
        [
            MembershipCardDB(
                name: "Antonio Hernández",
                email: "antonio@example.com",
                membership: .adult,
                qrCode: sampleQRCodeData
            ),
            MembershipCardDB(
                name: "María López",
                email: "maria@example.com",
                membership: .student,
                qrCode: sampleQRCodeData
            )
        ]
    }
}
