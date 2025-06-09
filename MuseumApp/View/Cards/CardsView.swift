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
    
    @State private var isPresentingForm = false
    
    // Esto solo se usa en preview
    var previewCards: [MembershipCardDB]? = nil

    var body: some View {
        let cards = previewCards ?? storedCards
        VStack {
            List {
                
                Section {
                    Button {
                                isPresentingForm = true
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle")
                                    Text("Add new card")
                                }
                            }
                }
                
                Section {
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
        .sheet(isPresented: $isPresentingForm) {
            FormView(formModel: CardsViewModel())
        }
    }
}

#Preview {
    CardsView(
        model: CardsViewModel(),
        previewCards: MembershipCardDB.dummyCards
    )
}
