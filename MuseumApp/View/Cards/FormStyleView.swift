//
//  FormStyleView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct FormView: View {
    @State var formModel: CardsViewModel
    @State private var showSuccessMessage = false
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            Section {
                VStack{
                    TextField(
                        "Full name",
                        text: $formModel.username
                    )
                    Divider()
                    .padding(.horizontal)
                    
                    TextField(
                        "User name (email address)",
                        text: $formModel.email
                    )
                    
                    if !formModel.isValidEmail(formModel.email) && !formModel.email.isEmpty {
                        Text("Please enter a valid email address")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                }
            }
            header: {
                Text("Personal data")
                    .font(.callout)
            }
            
            Section {
                Picker("Select", selection: $formModel.kindMemershipSelected) {
                    ForEach(formModel.kindMemership, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            header: {
                Text("KIND OF MEMERSHIP")
                    .font(.callout)
            }
            Button("Become a member now") {
                formModel.saveToDatabase(context: context)
                showSuccessMessage = true
            }
            .disabled(!formModel.isFormValid)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .alert("Card saved successfully!", isPresented: $showSuccessMessage) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
}

#Preview {
    FormView(formModel: .init())
}
