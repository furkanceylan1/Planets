//
//  CircleGroupView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct CircleGroupView: View {
    // MARK: - Properties
    @State private var isAnimation: Bool = false
    @State private var isImageAnimation: Bool = false
    @State private var rotationDegrees: Double = 0.0
    
    var body: some View {
        ZStack {
            ForEach(1..<4) { index in
                Circle()
                    .stroke(Color.white, lineWidth: CGFloat(index * 30))
                    .frame(width: 250)
                    .opacity(isAnimation ? 0.2 : 0)
                    .animation(.easeOut(duration: 0.5)
                        .delay(0.4 * Double(index))
                               , value: isAnimation)
            }
            Image(.moon)
                .resizable()
                .scaledToFit()
                .scaleEffect(isImageAnimation ? 0.6 : 0)
                .rotationEffect(Angle(degrees: rotationDegrees))
                .animation(.linear(duration: 2), value: isImageAnimation)
            
        }//: ZStack
        .onAppear {
            isAnimation = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isImageAnimation = true
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotationDegrees = 360.0
                }
            }
        }
    }
}

#Preview {
    ZStack {
        CircleGroupView()
    }
}
