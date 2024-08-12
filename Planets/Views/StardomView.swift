//
//  StardomView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct StardomView: View {
    // MARK: - Properties
    @State private var randomStar: Int = Int.random(in: 80...150)
    
    // MARK: - Functions
    func randomCoordinate() -> CGFloat{
        return CGFloat.random(in: 0...800)
    }
    
    func randomSize() -> CGFloat{
        return CGFloat.random(in: 1...10)
    }
    
    var body: some View {
        
        ForEach(0 ..< randomStar, id: \.self) { item in
            StarShape()
                .frame(width: randomSize())
                .position(CGPoint(x: randomCoordinate(), y: randomCoordinate()))
                .opacity(0.4)
        }
    }
}

#Preview {
    StardomView()
}

// MARK: - Star Shape
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let pointsOnStar = 5
        var path = Path()

        let angle = 2 * .pi / Double(pointsOnStar)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.5

        for i in 0..<pointsOnStar {
            let outerPoint = CGPoint(
                x: center.x + CGFloat(cos(Double(i) * angle)) * radius,
                y: center.y + CGFloat(sin(Double(i) * angle)) * radius
            )
            let innerPoint = CGPoint(
                x: center.x + CGFloat(cos(Double(i) * angle + angle / 2)) * innerRadius,
                y: center.y + CGFloat(sin(Double(i) * angle + angle / 2)) * innerRadius
            )

            if i == 0 {
                path.move(to: outerPoint)
            } else {
                path.addLine(to: outerPoint)
            }

            path.addLine(to: innerPoint)
        }

        path.closeSubpath()

        return path
    }
}
