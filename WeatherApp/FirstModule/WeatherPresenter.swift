//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

struct WeatherInfo {
    let temperature: Int
    let city: String
}

final class WeatherPresenter: WeatherViewOutputProtocol {
    unowned private let view: WeatherViewInputProtocol
    var interactor: WeatherInteractorInputProtocol!
    
    required init(view: WeatherViewInputProtocol) {
        self.view = view
    }
    
    func didTapShowWeather() {
        interactor.provideWeatherData()
    }
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func receiveWeatherData(weatherInfo: WeatherInfo) {
        let tempInfo = "Температура в г. \(weatherInfo.city) - \(String(weatherInfo.temperature))"
        view.setInfo(tempInfo)
    }
}
