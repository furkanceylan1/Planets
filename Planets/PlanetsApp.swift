//
//  PlanetsApp.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI

@main
struct PlanetsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    planetModelArray = []
                    for planet in stackPlanet{
                        NetworkManager().getData(with: planet.name) { planetModel in
                            planetModelArray.append(planetModel)
                        }
                    }
                })
        }
    }
}
