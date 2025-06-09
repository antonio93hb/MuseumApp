//
//  CardView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 3/6/25.
//

import SwiftUI
import SwiftData

struct CardComponentView: View {
    let card: MembershipCardDB
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(card.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(card.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(card.membership.rawValue)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            card.qrCodeImage
                .resizable()
                .frame(width: 100 , height: 100)
                .padding()

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(card.membership.color.opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    CardComponentView(card: .preview)
}
