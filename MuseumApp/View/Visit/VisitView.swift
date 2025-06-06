//
//  VisitView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 5/6/25.
//

import SwiftUI

struct VisitView: View {
    @State private var selectedDate = Date()
    @State private var selectedHour: Hours? = nil
    @State private var showAlert: Bool = false
    var body: some View {
        VStack{
            Form{
                Section {
                    DatePicker(
                        "Select a date",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                }
                header : {
                    Text("Select a date")
                }
                
                Section {
                    Menu {
                        ForEach(Hours.allCases) { hour in
                            Button(hour.rawValue) {
                                selectedHour = hour
                            }
                        }
                    } label: {
                        HStack {
                            Text("Hour")
                            Spacer()
                            Text(selectedHour?.rawValue ?? "")
                            
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.gray)
                        }
                        .foregroundColor(.blue)
                    }
                }
                header: {
                    Text("Select a hour")
                }
                if selectedHour != nil {
                    Section {
                        Button {
                            showAlert = true
                        } label: {
                            Text("Visit")
                        }
                        .disabled(selectedHour == nil)
                    }
                    footer: {
                        Text("The visit is \(selectedDate.formattedVisitDate()) at hour  \(selectedHour?.rawValue ?? "")")
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                .init(
                    title: Text("Visit"),
                    message: Text("You have visited the museum at \(selectedDate.formattedVisitDate()) at hour  \(selectedHour?.rawValue ?? "")")
                )
            }
        }
    }
}

#Preview {
    VisitView()
}
