//
//  Data.swift
//  sunset-app
//
//  Created by Adrian Ma on 4/22/23.
//

import SwiftUI

struct WeatherData: Codable {
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    let coord: [Coord]
    struct Weather: Codable {
        let main: String
        let description: String
    }
    let weather: [Weather]
    struct Sys: Codable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    let sys: [Sys]
    let timezone: Int
    let name: String
}

class Api {
    private let apiAddress = "https://api.openweathermap.org/data/2.5/weather"
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (WeatherData) -> ()){
        guard let url = URL(string: "\(apiAddress)?lat=\(latitude)&lon=\(longitude)&APPID=\(Secret.APPID)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let weatherData = try! JSONDecoder().decode(WeatherData.self, from: data!)
            DispatchQueue.main.async {
                completion(weatherData)
            }
        }
        .resume()
    }
}
