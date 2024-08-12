//
//  ContentView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("homeView") var isHomeViewActive: Bool = false
    
    var body: some View {
        if isHomeViewActive{
            HomeView()
        }else{
            OnboardingView()
        }
    }
        
}

#Preview {
    ContentView()
}
