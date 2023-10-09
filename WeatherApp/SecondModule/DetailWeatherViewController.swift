//
//  DetailWeatherViewController.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import UIKit

protocol DetailWeatherViewInputProtocol: AnyObject {
    func displayImageForBackground(with imageName: String)
    func displayImageForDisplayInfoView(with imageName: String)
    func displayImageForWeatherImage(with imageName: String)
    func displayIconForHumidity(with imageName: String)
    func displayIconForWind(with imageName: String)
    func displayCityName(with title: String)
    func displayTemp(with temp: String, minTemp: String, maxTemp: String)
    func displayHumidity(with humidity: String)
    func displayWind(with windSpeed: String)
}

protocol DetailWeatherViewOutputProtocol {
    init(view: DetailWeatherViewInputProtocol)
    func showDetails()
}

final class DetailWeatherViewController: UIViewController {
    var weather: WeatherData!
    var presenter: DetailWeatherViewOutputProtocol!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayInfoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.textAlignment = .left
        label.textColor = .black
        label.font = label.font.withSize(40)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.showDetails()
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
    func displayImageForDisplayInfoView(with imageName: String) {
        displayInfoView.image = UIImage(named: imageName)
    }
    
    func displayImageForWeatherImage(with imageName: String) {
        weatherImage.image = UIImage(named: imageName)
    }
    
    func displayIconForHumidity(with imageName: String) {
        humidityIcon.image = UIImage(named: imageName)
    }
    
    func displayIconForWind(with imageName: String) {
        windIcon.image = UIImage(named: imageName)
    }
    
    func displayImageForBackground(with imageName: String) {
        backgroundImageView.image = UIImage(named: imageName)
    }
    
    func displayHumidity(with humidity: String) {
        humidityLabel.text = humidity
    }
    
    func displayWind(with windSpeed: String) {
        windLabel.text = windSpeed
    }
    
    func displayTemp(with temp: String, minTemp: String, maxTemp: String) {
        tempLabel.text = temp
        tempMinLabel.text = minTemp
        tempMaxLabel.text = maxTemp
    }
    
    func displayCityName(with title: String) {
        cityName.text = title
    }
}
