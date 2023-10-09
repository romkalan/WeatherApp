//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

protocol WeatherInteractorInputProtocol {
    init(presenter: WeatherInteractorOutputProtocol)
    func fetchWeather()
    func addNewCity(with cityName: String)
    func deleteRow(at indexPath: IndexPath)
}

protocol WeatherInteractorOutputProtocol: AnyObject {
    func weatherDidReceive(with dataStore: WeatherInfoDataStore)
}

final class WeatherInteractor: WeatherInteractorInputProtocol {
    private let networkManager = NetworkManager.shared
    
    private let emptyCity = WeatherData()
    private var citiesWeather: [WeatherData] = []
    private var array: [WeatherData] = []
    private var cities = ["New York", "Moscow", "Paris", "Berlin"]
    
    private unowned let presenter: WeatherInteractorOutputProtocol
    
    required init(presenter: WeatherInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchWeather() {
        if citiesWeather.isEmpty {
            citiesWeather = Array(repeating: emptyCity, count: cities.count)
        }
        networkManager.getCityWeather(citiesArray: cities) { [unowned self] index, weather in
            citiesWeather[index] = weather
            citiesWeather[index].name = cities[index]
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let dataStore = WeatherInfoDataStore(weather: self.citiesWeather)
            self.presenter.weatherDidReceive(with: dataStore)
        }
    }
    
    func addNewCity(with cityName: String) {
        cities.append(cityName)
        
        networkManager.addNewCityWeather(with: cityName) { [unowned self] weather in
            citiesWeather.append(weather)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let dataStore = WeatherInfoDataStore(weather: self.citiesWeather)
            self.presenter.weatherDidReceive(with: dataStore)
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        citiesWeather.remove(at: indexPath.row)
        let dataStore = WeatherInfoDataStore(weather: self.citiesWeather)
        self.presenter.weatherDidReceive(with: dataStore)
    }
}
