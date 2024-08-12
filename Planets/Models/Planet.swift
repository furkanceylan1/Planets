//
//  Planet.swift
//  Planets
//
//  Created by Furkan Ceylan on 12.08.2024.
//

import Foundation

struct Planet: Identifiable {
    var id = UUID().uuidString
    var name: String
    var planetImage: String
}

var stackPlanet: [Planet] = [
    Planet(name: "Mercury", planetImage: "Mercury.usdz"),
    Planet(name: "Venus", planetImage: "Venus.usdz"),
    Planet(name: "Earth", planetImage: "Earth.usdz"),
    Planet(name: "Mars", planetImage: "Mars.usdz"),
    Planet(name: "Jupiter", planetImage: "Jupiter.usdz"),
    Planet(name: "Saturn", planetImage: "Saturn.usdz"),
    Planet(name: "Uranus", planetImage: "Uranus.usdz"),
    Planet(name: "Neptune", planetImage: "Neptune.usdz"),
    Planet(name: "Pluto", planetImage: "Pluto.usdz")
]
