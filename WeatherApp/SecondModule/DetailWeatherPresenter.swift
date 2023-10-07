//
//  DetailWeatherPresenter.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation

struct DetailWeatherDataStore {
    
}

class DetailWeatherPresenter: DetailWeatherViewOutputProtocol {
    var interactor: DetailWeatherInteractorInputProtocol!
    private unowned let view: DetailWeatherViewInputProtocol
    
    required init(view: DetailWeatherViewInputProtocol) {
        self.view = view
    }
    
    func showDetail() {
        
    }
    
}

// MARK: - DetailWeatherInteractorOutputProtocol
extension DetailWeatherPresenter: DetailWeatherInteractorOutputProtocol {
    
}
