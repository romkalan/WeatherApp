//
//  DetailWeatherInteractor.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation
protocol DetailWeatherInteractorInputProtocol {
    init(presenter: DetailWeatherInteractorOutputProtocol, weather: Weather)
    func provideWeatherDetails()
}

protocol DetailWeatherInteractorOutputProtocol: AnyObject {
    
}

class DetailWeatherInteractor: DetailWeatherInteractorInputProtocol {
    private unowned let presenter: DetailWeatherInteractorOutputProtocol
    private let weather: Weather
    
    required init(presenter: DetailWeatherInteractorOutputProtocol, weather: Weather) {
        self.presenter = presenter
        self.weather = weather
    }
    
    func provideWeatherDetails() {
        
    }
}
