//
//  ViewController.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import UIKit

protocol WeatherViewInputProtocol: AnyObject {
    func setInfo(_ info: String)
}

protocol WeatherViewOutputProtocol {
    init(view: WeatherViewInputProtocol)
    func didTapShowWeather()
}

final class WeatherViewController: UIViewController {
    var presenter: WeatherViewOutputProtocol!
    
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    private var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        view.backgroundColor = .blue
        weather = Weather(temperature: 24, city: "Москва")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presenter.didTapShowWeather()
    }
}

//MARK: - MainViewInputProtocol
extension WeatherViewController: WeatherViewInputProtocol {
    func setInfo(_ info: String) {
        <#code#>
    }
}

