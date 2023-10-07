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
    
    private let networkManager = NetworkManager.shared
    private let configurator: WeatherConfiguratorInputProtocol = WeatherConfigurator()
    
    let emptyCity = WeatherData()
    private var citiesWeather: [WeatherData] = []
    private var cities = ["New York", "Moscow", "Paris", "Berlin", "Madrid"]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(WeatherCityCell.self, forCellReuseIdentifier: WeatherCityCell.cellID)
        table.separatorColor = .gray
        let backgroundImage = UIImage(named: "background")
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        tableView.dataSource = self
        tableView.delegate = self
                
        setupUI()
        addCities()
    }
    
    func addCities() {
        if citiesWeather.isEmpty {
            citiesWeather = Array(repeating: emptyCity, count: cities.count)
        }
        
        networkManager.getCityWeather(citiesArray: cities) { [unowned self] index, weather in
            citiesWeather[index] = weather
            citiesWeather[index].name = cities[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presenter.didTapShowWeather()
    }
}

// MARK: - SetupUI
private extension WeatherViewController {
    func setupUI() {
        addViews()
        setupNavBar()
        setConstraints()
    }
    
    func setupNavBar() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherCityCell.cellID,
            for: indexPath
        ) as? WeatherCityCell else { return UITableViewCell() }
        
        let weather = citiesWeather[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(weather: weather)
        
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailWeatherViewController()
        
        let weather = citiesWeather[indexPath.row]
        vc.configure(weather: weather)
        
        if !(self.navigationController!.topViewController! is DetailWeatherViewController) {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - MainViewInputProtocol
extension WeatherViewController: WeatherViewInputProtocol {
    func setInfo(_ info: String) {
        
    }
}

