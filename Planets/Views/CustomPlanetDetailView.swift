//
//  CustomPlanetDetailView.swift
//  Planets
//
//  Created by Furkan Ceylan on 12.08.2024.
//

import SwiftUI

struct CustomPlanetDetailView: View {
    // MARK: - Properties
    @State var title: String
    @State var value: String
    // MARK: - Content
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.pink.opacity(0.7))
            
            VStack {
                Text(title)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding(.top, 25)
                Spacer()
                Text(value)
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    CustomPlanetDetailView(title: "Earth", value: "0.0")
}
