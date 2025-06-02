//
//  FormStyleView.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 2/6/25.
//

import SwiftUI

struct FormView: View {
    @State private var selected = "Adult"
    @State private var username: String = ""
    @State private var email: String = ""
    
    let options = ["Adult", "Studient", "Senior", "Junior"]
    
    var body: some View {
        Form {
            Section {
                VStack{
                    TextField(
                        "Full name",
                        text: $username
                    )
                    TextField(
                        "User name (email address)",
                        text: $email
                    )
                }
            }
            header: {
                Text("Personal data")
                    .font(.callout)
            }
            
            Section {
                Picker("Select", selection: $selected) {
                    ForEach(options, id: \.self) { option in
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
            
            Button {
                print("Join clicked!")
            } label: {
                Text("Become a member now")
                    .foregroundColor(.blue)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    FormView()
}
