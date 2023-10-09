//
//  DetailWeatherInteractor.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation

protocol DetailWeatherInteractorInputProtocol {
    init(presenter: DetailWeatherInteractorOutputProtocol, weather: WeatherData)
    func provideWeatherDetails()
}

protocol DetailWeatherInteractorOutputProtocol: AnyObject {
    func receiveDetailWeather(with dataStore: DetailWeatherDataStore)
}

final class DetailWeatherInteractor: DetailWeatherInteractorInputProtocol {
    private unowned let presenter: DetailWeatherInteractorOutputProtocol
    private let weather: WeatherData
    
    required init(presenter: DetailWeatherInteractorOutputProtocol, weather: WeatherData) {
        self.presenter = presenter
        self.weather = weather
    }
    
    func provideWeatherDetails() {
        let dataStore = DetailWeatherDataStore(
            backgroundImage: "background",
            displayInfoImage: "displayWeather",
            weatherImage: "SunCloudMidRain",
            humidityIcon: "raindDropIcon",
            windIcon: "windVectorIcon",
            cityName: weather.name,
            tempAverage: weather.main.temp,
            tempMin: weather.main.tempMin,
            tempMax: weather.main.tempMax,
            humidity: weather.main.humidity,
            windSpeed: weather.wind.speed
        )
        presenter.receiveDetailWeather(with: dataStore)
    }
}
