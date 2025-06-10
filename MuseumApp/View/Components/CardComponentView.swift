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
    
    private var gradientColors: [Color] {
        let base = card.membership.color
        return [base, base.opacity(0.7)]
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 6)
            
            HStack {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.bottom, 8)
                    Text(card.name)
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(card.email)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(alignment: .leading) {
                        Text("CATEGORY")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                        Text(card.membership.rawValue)
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    .padding(.top)
                }
                
                Spacer(minLength: 0)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(radius: 8)
                    
                    card.qrCodeImage
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                }
                .frame(width: 100, height: 100)
            }
            .padding()
        }
        .shadow(radius: 10)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}

#Preview {
    List{
        CardComponentView(card: .preview)
    }
}
