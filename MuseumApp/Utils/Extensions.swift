//
//  Helper.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 5/6/25.
//
import Foundation

extension Date {
    func formattedVisitDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
