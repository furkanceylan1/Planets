//
//  OnboardingView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        ZStack {
            //Add The Stardom
            StardomView()
                .ignoresSafeArea()
            
            VStack {
                // MARK: - Section Header
                VStack(spacing: 10) {
                    Text("Planets")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    Text("Welcome the Planets App")
                        .font(.headline)
                }//: VStack
                .padding(.top, 50)
                Spacer()
                // MARK: - Section Content
                CircleGroupView()
                Spacer()
                // MARK: - Section Footer
                CustomStartButtonView()
                
            }//: VStack Submain
        }//: ZStack Main
        .background(Color.indigo)
    }
}

#Preview {
    ZStack {
        Color.indigo
            .ignoresSafeArea()
        OnboardingView()
            .foregroundStyle(.white)
    }
}
