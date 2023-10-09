//
//  DetailWeatherPresenter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation

struct DetailWeatherDataStore {
    let backgroundImage: String
    let displayInfoImage: String
    let weatherImage: String
    let humidityIcon: String
    let windIcon: String
    let cityName: String
    let tempAverage: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let windSpeed: Double
}

final class DetailWeatherPresenter: DetailWeatherViewOutputProtocol {
    var interactor: DetailWeatherInteractorInputProtocol!
    private unowned let view: DetailWeatherViewInputProtocol
    
    required init(view: DetailWeatherViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideWeatherDetails()
    }
    
    private func celsiusConvert(from kelvin: Double) -> String {
        String(format: "%.1f", kelvin - 273.15)
    }
}

// MARK: - DetailWeatherInteractorOutputProtocol
extension DetailWeatherPresenter: DetailWeatherInteractorOutputProtocol {
    func receiveDetailWeather(with dataStore: DetailWeatherDataStore) {
        let tempOnCelcius = celsiusConvert(from: dataStore.tempAverage) + " °C"
        let tempMaxOnCelsius = celsiusConvert(from: dataStore.tempMax) + " °C"
        let tempMinOnCelcius = celsiusConvert(from: dataStore.tempMin) + " °C"
        let humidity = String(dataStore.humidity) + " %"
        let windSpeed = String(dataStore.windSpeed) + " m/s"
        
        view.displayImageForBackground(with: dataStore.backgroundImage)
        view.displayImageForDisplayInfoView(with: dataStore.displayInfoImage)
        view.displayImageForWeatherImage(with: dataStore.weatherImage)
        view.displayIconForHumidity(with: dataStore.humidityIcon)
        view.displayIconForWind(with: dataStore.windIcon)
        
        view.displayCityName(with: dataStore.cityName)
        view.displayWind(with: windSpeed)
        view.displayHumidity(with: humidity)
        view.displayTemp(
            with: tempOnCelcius,
            minTemp: tempMinOnCelcius,
            maxTemp: tempMaxOnCelsius
        )
    }
}
