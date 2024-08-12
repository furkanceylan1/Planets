//
//  PlanetDataModel.swift
//  Planets
//
//  Created by Furkan Ceylan on 12.08.2024.
//

import Foundation

struct PlanetDataModel: Codable {
    var Name: String
    var Mass: Double
    var Radius: Double
    var Period: Double
    var MajorAxis: Double
    var Temperature: Double
    var DistanceLightYear: Double
    var HostStarMass: Double
    var HostStarTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case Name = "name"
        case Mass = "mass"
        case Radius = "radius"
        case Period = "period"
        case MajorAxis = "semi_major_axis"
        case Temperature = "temperature"
        case DistanceLightYear = "distance_light_year"
        case HostStarMass = "host_star_mass"
        case HostStarTemperature = "host_star_temperature"
    }
}

var planetModelArray: [[PlanetDataModel]] = []
