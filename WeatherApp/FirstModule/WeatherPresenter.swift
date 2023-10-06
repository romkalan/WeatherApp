//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

struct WeatherData {
    let temperature: Int
    let city: String
}

class WeatherPresenter: WeatherViewOutputProtocol {
    unowned private let view: WeatherViewInputProtocol
    var interactor: MainInteractorInputProtocol!
    
    required init(view: WeatherViewInputProtocol) {
        self.view = view
    }
    
    func didTapShowWeather() {
        interactor.provideWeatherData()
    }
}

extension WeatherPresenter: MainInteractorOutputProtocol {
    func receiveWeatherData(weatherData: WeatherData) {
        let tempInfo = "Температура в г. \(weatherData.city) - \(String(weatherData.temperature))"
        view.setInfo(tempInfo)
    }
}
