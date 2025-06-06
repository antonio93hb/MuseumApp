//
//  CardsView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 3/6/25.
//

import SwiftUI
import SwiftData

struct CardsView: View {
    @Environment(\.modelContext) private var context
    @State var model: CardsViewModel
    @Query private var storedCards: [MembershipCardDB]
    
    // Esto solo se usa en preview
    var previewCards: [MembershipCardDB]? = nil

    var body: some View {
        let cards = previewCards ?? storedCards
        VStack {
            Text("Cards")
            List {
                ForEach(cards) {card in
                    CardComponentView(card: card)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let itemToDelete = cards[index]
                        context.delete(itemToDelete)
                    }
                }
            }
        }
    }
}

#Preview {
    CardsView(
        model: CardsViewModel(),
        previewCards: MembershipCardDB.dummyCards
    )
}
