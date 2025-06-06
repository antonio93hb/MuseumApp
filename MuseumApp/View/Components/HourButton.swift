//
//  HourButton.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 5/6/25.
//

import SwiftUI

enum Hours: String, CaseIterable, Identifiable {
    
    case ten = "10:00"
    case eleven = "11:00"
    case twelve = "12:00"
    case one = "13:00"
    case two = "14:00"
    case three = "15:00"
    case four = "16:00"
    case five = "17:00"
    
    var id: Self { self }
}

struct HourButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
}

//#Preview {
//    HourButton()
//}
