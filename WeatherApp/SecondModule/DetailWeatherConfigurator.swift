//
//  DetailWeatherConfigurator.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation

protocol DetailWeatherConfiguratorInputProtocol {
    func configure(withView view: DetailWeatherViewController, and weather: Weather)
}

class DetailWeatherConfigurator: DetailWeatherConfiguratorInputProtocol {
    func configure(withView view: DetailWeatherViewController, and weather: Weather) {
        let presenter = DetailWeatherPresenter(view: view)
        let interactor = DetailWeatherInteractor(presenter: presenter, weather: weather)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
