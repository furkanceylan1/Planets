//
//  CustomStartButtonView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct CustomStartButtonView: View {
    @State private var buttonOffset: CGFloat = 0.0
    @State private var buttonWidth: CGFloat = UIScreen.main.bounds.width - 80
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    @AppStorage("homeView") var isHomeViewActive: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50.0)
                .fill(.pink.opacity(0.3))
            RoundedRectangle(cornerRadius: 50.0)
                .fill(.pink.opacity(0.3))
                .padding(10)
            Text("Go to Home Page")
                .font(.headline)
            HStack {
                ZStack {
                    Circle()
                        .fill(.indigo)
                        .padding(10)
                    Image(systemName: "chevron.forward.2")
                        .font(.headline)
                }
                .offset(x: buttonOffset)
                .shadow(color: .white, radius: 2)
                Spacer()
            }//: HStack
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 90 {
                            
                            buttonOffset = gesture.translation.width
                        }
                    })
                
                    .onEnded({ gesture in
                        withAnimation(.linear(duration: 0.2)) {
                            if buttonOffset > buttonWidth / 2{
                                isHomeViewActive = true
                                hapticFeedback.notificationOccurred(.success)
                                DispatchQueue.main.async {
                                    audioPlayer(sound: "success", extention: "mp3")
                                }
                            }else{
                                isHomeViewActive = false
                            }
                            buttonOffset = 0
                        }
                    })
            )
        }//: ZStack
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 90)
        .foregroundStyle(.white)
    }
}

#Preview {
    CustomStartButtonView()
}
