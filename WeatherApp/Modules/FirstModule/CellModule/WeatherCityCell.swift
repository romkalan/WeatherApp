//
//  WeatherCityCell.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import UIKit

protocol WeatherCityCellViewModelRepresentable {
    var viewModel: WeatherCityCellViewModelProtocol? { get }
}

final class WeatherCityCell: UITableViewCell, WeatherCityCellViewModelRepresentable {
    var viewModel: WeatherCityCellViewModelProtocol? {
        didSet {
            setupUI()
            updateView()
        }
    }
        
    private let cityName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func updateView() {
        guard let viewModel = viewModel as? WeatherCityCellViewModel else { return }
        cityName.text = viewModel.cityName
        tempLabel.text = viewModel.cityTemp
        if let imageName = viewModel.imageName {
            weatherImageView.image = UIImage(named: imageName)
        }
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
//            weatherImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            weatherImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100),
            
            cityName.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            cityName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 150),
            
            tempLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
        ])
    }
}
