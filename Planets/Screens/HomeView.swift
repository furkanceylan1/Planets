//
//  HomeView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("homeView") var isHomeViewActive: Bool = false
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.clear.ignoresSafeArea()
                // MARK: - Background Stardom
                
                // MARK: - Buttons
                StardomView()
                
                VStack{
                    NavigationLink(destination: PlanetsView()) {
                        
                        CustomButtonView(imageName: "restart", buttonText: "Start", buttonBackgroundColor: Color.teal)
                    }
                    
                    CustomButtonView(imageName: "gobackward", buttonText: "Restart", buttonBackgroundColor: Color.pink)
                        .onTapGesture {
                            isHomeViewActive = false
                            hapticFeedback.notificationOccurred(.success)
                            DispatchQueue.main.async {
                                audioPlayer(sound: "success", extention: "mp3")
                            }
                        }
                }
            }//: ZStack
        }//: Navigation Stack
        
    }
}

#Preview {
    ZStack {
        Color.indigo
            .ignoresSafeArea()
        HomeView()
    }
}
