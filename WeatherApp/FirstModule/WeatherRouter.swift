//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation

protocol WeatherRouterInputProtocol {
    init(view: WeatherViewController)
    func openDetailWeatherViewController(with weather: WeatherData, for view: Any?)
}

final class WeatherRouter: WeatherRouterInputProtocol {
    private unowned let view: WeatherViewInputProtocol
    
    required init(view: WeatherViewController) {
        self.view = view
    }
    
    func openDetailWeatherViewController(with weather: WeatherData, for view: Any?) {
        let view = view as? WeatherViewController
        let detailVC = DetailWeatherViewController()
        detailVC.weather = weather
        let configurator: DetailWeatherConfiguratorInputProtocol = DetailWeatherConfigurator()
        configurator.configure(withView: detailVC, and: weather)
        
        if !(view?.navigationController!.topViewController! is DetailWeatherViewController) {
            view.self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
