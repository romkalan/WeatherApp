//
//  WeatherCityCellViewModel.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 08.10.2023.
//

import Foundation

protocol WeatherCityCellViewModelProtocol {
    var cellID: String { get }
    var cellHeight: Double { get }
    var cityName: String { get }
    var cityTemp: String { get }
    var imageName: String? { get }
    
    init(weather: WeatherData)
}

protocol WeatherCitySectionViewModelProtocol {
    var rows: [WeatherCityCellViewModelProtocol] { get }
    var numberOfRows: Int { get }
}

final class WeatherCityCellViewModel: WeatherCityCellViewModelProtocol {
    private let weatherIcons = ["SunCloudMidRain", "SunCloudMidRain2", "SunCloudMidRain3", "SunCloudMidRain4"]
    
    var cityTemp: String {
        celsiusConvert(from: weather.main.temp) + " °C"
    }
    
    var cellID: String {
        "weatherCell"
    }
    
    var cellHeight: Double {
        80
    }
    
    var cityName: String {
        weather.name
    }
    
    var imageName: String? {
        let randomNumber = Int.random(in: 0...3)
        let imageName = weatherIcons[randomNumber]
        return imageName
    }
    
    private let weather: WeatherData
    
    required init(weather: WeatherData) {
        self.weather = weather
    }
    
    private func celsiusConvert(from kelvin: Double) -> String {
        String(format: "%.1f", kelvin - 273.15)
    }
}

final class WeatherCitySectionViewModel: WeatherCitySectionViewModelProtocol {
    var rows: [WeatherCityCellViewModelProtocol] = []
    
    var numberOfRows: Int {
        rows.count
    }
}
