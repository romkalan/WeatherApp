//
//  DetailWeatherViewController.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import UIKit

protocol DetailWeatherViewInputProtocol: AnyObject {
    
}

protocol DetailWeatherViewOutputProtocol {
    init(view: DetailWeatherViewInputProtocol)
    func showDetail()
}

final class DetailWeatherViewController: UIViewController {
    
    var weather: WeatherData!
    var presenter: DetailWeatherViewOutputProtocol!
    var configurator: DetailWeatherConfiguratorInputProtocol = DetailWeatherConfigurator()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayInfoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "displayWeather")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SunCloudMidRain")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.text = "Наименование"
        label.textAlignment = .left
        label.textColor = .black
        label.font = label.font.withSize(40)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.textAlignment = .right
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "raindDropIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Влажность"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "windVectorIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "Скорость"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.showDetail()
    }
    
    func configure(weather: WeatherData) {
        cityName.text = weather.name
        tempLabel.text = celsiusConvert(from: weather.main.temp) + " °C"
        tempMaxLabel.text = celsiusConvert(from: weather.main.tempMax) + " °C"
        tempMinLabel.text = celsiusConvert(from: weather.main.tempMin) + " °C"
        humidityLabel.text = String(weather.main.humidity) + " %"
        windLabel.text = String(weather.wind.speed) + " m/s"
    }
    
    private func celsiusConvert(from kelvin: Double) -> String {
        String(format: "%.1f", kelvin - 273.15)
    }
}

// MARK: - SetupUI
private extension DetailWeatherViewController {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(displayInfoView)
        view.addSubview(weatherImage)
        displayInfoView.addSubview(cityName)
        displayInfoView.addSubview(tempLabel)
        displayInfoView.addSubview(tempMinLabel)
        displayInfoView.addSubview(tempMaxLabel)
        displayInfoView.addSubview(humidityIcon)
        displayInfoView.addSubview(windIcon)
        displayInfoView.addSubview(humidityLabel)
        displayInfoView.addSubview(windLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            displayInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayInfoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            displayInfoView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            displayInfoView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: displayInfoView.topAnchor, constant: 210),
            
            cityName.centerXAnchor.constraint(equalTo: displayInfoView.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: displayInfoView.centerYAnchor, constant: -30),
            
            tempLabel.centerXAnchor.constraint(equalTo: displayInfoView.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 20),
            
            tempMinLabel.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            tempMinLabel.rightAnchor.constraint(equalTo: tempLabel.layoutMarginsGuide.leftAnchor, constant: -30),
            
            tempMaxLabel.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            tempMaxLabel.leftAnchor.constraint(equalTo: tempLabel.layoutMarginsGuide.rightAnchor, constant: 30),
            
            humidityIcon.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor, constant: 30),
            humidityIcon.leftAnchor.constraint(equalTo: displayInfoView.layoutMarginsGuide.leftAnchor, constant: 25),
            
            humidityLabel.centerYAnchor.constraint(equalTo: humidityIcon.centerYAnchor),
            humidityLabel.leftAnchor.constraint(equalTo: humidityIcon.layoutMarginsGuide.rightAnchor, constant: 16),
            
            windIcon.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor, constant: 30),
            windIcon.rightAnchor.constraint(equalTo: windLabel.layoutMarginsGuide.leftAnchor, constant: -16),
            
            windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor),
            windLabel.rightAnchor.constraint(equalTo: displayInfoView.layoutMarginsGuide.rightAnchor, constant: -25)
        ])
    }
}

//MARK: - DetailWeatherViewInputProtocol
extension DetailWeatherViewController: DetailWeatherViewInputProtocol {
    
}
