//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

protocol WeatherInteractorInputProtocol {
    init(presenter: WeatherInteractorOutputProtocol)
    func provideWeatherData()
}

protocol WeatherInteractorOutputProtocol: AnyObject {
    func receiveWeatherData(weatherData: WeatherData)
}

class WeatherInteractor: WeatherInteractorInputProtocol {
    unowned private let presenter: WeatherInteractorOutputProtocol!
    
    required init(presenter: WeatherInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideWeatherData() {
        let weather = Weather(temperature: 24, city: "Москва")
        let weatherData = WeatherData(temperature: weather.temperature, city: weather.city)
        presenter.receiveWeatherData(weatherData: weatherData)
    }
}
