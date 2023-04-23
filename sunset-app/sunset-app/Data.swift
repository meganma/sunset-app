//
//  Data.swift
//  sunset-app
//
//  Created by Adrian Ma on 4/22/23.
//

import SwiftUI

struct WeatherData : Codable {
    let coord : Coordinate
    let name : String
    let weather : [Weather]
    let sys : Sys
}

struct Coordinate : Codable {
    let lon, lat : Double
}

struct Weather : Codable {
    let id : Int
    let icon : String
    let main : MainEnum
    let description: String
}

struct Sys : Codable {
    let type, id : Int
    let sunrise, sunset : Date
    let message : Double? // Message must be optional otherwise JSON parse failure
    let country : String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
