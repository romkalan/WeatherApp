//
//  Weather.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

// MARK: - Reservation
struct WeatherData: Codable {
    var coord: Coord = Coord(lon: 0, lat: 0)
    var weather: [Weather] = [Weather(id: 0, main: "", description: "", icon: "")]
    var main: Main = Main(temp: 0, tempMin: 0, tempMax: 0, humidity: 0)
    var wind: Wind = Wind(speed: 0, deg: 0)
    var sys: Sys = Sys(country: "")
    var id: Int = 0
    var name: String = ""
    
    init() {}
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
