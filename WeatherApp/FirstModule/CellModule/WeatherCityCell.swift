//
//  WeatherCityCell.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import UIKit

class WeatherCityCell: UITableViewCell {
    
    static let cellID = "weatherCell"
    private let weatherIcons = ["SunCloudMidRain", "SunCloudMidRain2", "SunCloudMidRain3", "SunCloudMidRain4"]
        
    private let cityName: UILabel = {
        let label = UILabel()
        label.text = "Наименование"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: "SunCloudMidRain")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(weather: WeatherData) {
        cityName.text = weather.name
        tempLabel.text = celsiusConvert(from: weather.main.temp) + " °C"
        let randomNumber = Int.random(in: 0...3)
        weatherImageView.image = UIImage(named: weatherIcons[randomNumber])
    }
    
    private func celsiusConvert(from kelvin: Double) -> String {
        String(format: "%.1f", kelvin - 273.15)
    }
}

private extension WeatherCityCell {
    func setupUI() {
        contentView.addSubview(weatherImageView)
        contentView.addSubview(cityName)
        contentView.addSubview(tempLabel)
        setConstraints()
    }
    
    func setConstraints() {        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            weatherImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            
            cityName.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            cityName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 150),
            
            tempLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
        ])
    }
}
