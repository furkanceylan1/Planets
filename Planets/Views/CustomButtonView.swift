//
//  CustomButtonView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct CustomButtonView: View {
    let imageName: String
    let buttonText: String
    let buttonBackgroundColor: Color
    
    var body: some View {
        ZStack{
            Capsule()
                .foregroundStyle(buttonBackgroundColor.opacity(0.7))
                .frame(width: 180)
            
            HStack {
                ZStack {
                    Circle()
                        .fill(buttonBackgroundColor)
                        .frame(width: 30)
                    
                    Image(systemName: imageName)
                        .fontWeight(.heavy)
                        .foregroundStyle(.indigo.opacity(0.7))
                    
                }
                
                Text(buttonText)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.system(size: 24))
            }
        }.frame(height: 60)
    }
}

#Preview {
    CustomButtonView(imageName: "restart", buttonText: "Restart", buttonBackgroundColor: Color.green)
}
