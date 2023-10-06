//
//  WeatherCityCell.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import UIKit

class WeatherCityCell: UITableViewCell {
    
    static let cellID = "weatherCell"
        
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = "Наименование"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func configure(weather: Reservation) {
        cityName.text = weather.name
        tempLabel.text = celsiusConvert(from: weather.main.temp) + " °C"
    }
    
    private func celsiusConvert(from kelvin: Double) -> String {
        String(format: "%.1f", kelvin - 273.15)
    }
}

private extension WeatherCityCell {
    
    func setupUI() {
        contentView.addSubview(cityName)
        contentView.addSubview(tempLabel)
        setConstraints()
    }
    
    func setConstraints() {        
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cityName.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
//            secondaryLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
//            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
//            secondaryLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16),
//            secondaryLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
        ])
    }
}
