//
//  MainConfigurator.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import Foundation

protocol WeatherConfiguratorInputProtocol {
    func configure(withView view: WeatherViewController)
}

class WeatherConfigurator: WeatherConfiguratorInputProtocol {
    func configure(withView view: WeatherViewController) {
        let presenter = WeatherPresenter(view: view)
        let interactor = WeatherInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
