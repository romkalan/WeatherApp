//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

struct WeatherInfoDataStore {
    let weather: [WeatherData]
}

final class WeatherPresenter: WeatherViewOutputProtocol {
    var interactor: WeatherInteractorInputProtocol!
    var router: WeatherRouterInputProtocol!
    
    unowned private let view: WeatherViewInputProtocol
    private var dataStore: WeatherInfoDataStore?
        
    required init(view: WeatherViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchWeather()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let weather = dataStore?.weather[indexPath.row] else { return }
        router.openDetailWeatherViewController(with: weather, for: view)
    }
    
    func didSwipeCell(at indexPath: IndexPath) {
        interactor.deleteRow(at: indexPath)
    }
    
    func didTapAddNewCity(with name: String) {
        interactor.addNewCity(with: name)
    }
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func weatherDidReceive(with dataStore: WeatherInfoDataStore) {
        self.dataStore = dataStore
        let section = WeatherCitySectionViewModel()
//        dataStore.weather.forEach { section.rows.append(WeatherCityCellViewModel(weather: $0)) }
        for weather in dataStore.weather {
            let weatherCityCellViewModel = WeatherCityCellViewModel(weather: weather)
            section.rows.append(weatherCityCellViewModel)
        }
        view.reloadData(for: section)
    }
}
