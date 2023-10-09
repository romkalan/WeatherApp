//
//  ViewController.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 05.10.2023.
//

import UIKit

protocol WeatherViewInputProtocol: AnyObject {
    func reloadData(for section: WeatherCitySectionViewModel)
    func deleteRow(at indexPath: IndexPath, for section: WeatherCitySectionViewModelProtocol)
}

protocol WeatherViewOutputProtocol {
    init(view: WeatherViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
    func didSwipeCell(at indexPath: IndexPath)
    func didTapAddNewCity(with name: String)
}

final class WeatherViewController: UIViewController {
    var presenter: WeatherViewOutputProtocol!
    private let configurator: WeatherConfiguratorInputProtocol = WeatherConfigurator()
    private var sectionViewModel: WeatherCitySectionViewModelProtocol = WeatherCitySectionViewModel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(WeatherCityCell.self, forCellReuseIdentifier: "weatherCell")
        table.separatorColor = .gray
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
        tableView.delegate = self
        tableView.dataSource = self
        configurator.configure(withView: self)
        setupUI()
        presenter.viewDidLoad()
    }
}

// MARK: - SetupUI
private extension WeatherViewController {
    func setupUI() {
        addViews()
        setupNavBar()
        setupActivityIndicator()
        setConstraints()
    }
    
    func setupNavBar() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction { [unowned self] _ in
                showAlert()
            }
        )
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
    }
    
    func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(activityIndicator)
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

// MARK: - Alert Controller
extension WeatherViewController {
    func showAlert() {
        let alert = UIAlertController(
            title: "Add City",
            message: "Add new City in your List of Weather",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            self.presenter.didTapAddNewCity(with: text)
        }
        alert.addAction(okAction)
        alert.addTextField { textField in
            textField.placeholder = "New City"
        }
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellViewModel.cellID,
            for: indexPath
        ) as? WeatherCityCell else { return UITableViewCell() }
        
        cell.viewModel = cellViewModel
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        return cellViewModel.cellHeight
    }
}

//MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (_, _, completion) in
            self.presenter.didSwipeCell(at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK: - MainViewInputProtocol
extension WeatherViewController: WeatherViewInputProtocol {
    func reloadData(for section: WeatherCitySectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func deleteRow(at indexPath: IndexPath, for section: WeatherCitySectionViewModelProtocol) {
        sectionViewModel = section
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
}

