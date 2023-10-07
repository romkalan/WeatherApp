//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Roman Lantsov on 06.10.2023.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    let APIKey = "Enter you APIKey"
    
    private init() {}
    
    //MARK: - fetch Data method
    func getCityWeather(citiesArray: [String], completion: @escaping(Int, WeatherData) -> Void) {
        for (index, value) in citiesArray.enumerated() {
            getCoordinateFrom(city: value) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                self.fetchData(WeatherData.self, latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
                    switch result {
                    case .success(let weather):
//                    print("Загрузка успешно \(weather) по индексу \(index)")
                        completion(index, weather)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func getCoordinateFrom(city: String, completion: @escaping(_: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
    
    func fetchData<T: Decodable>(_ type: T.Type, latitude: Double, longitude: Double, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        let urlAPI = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey)"
        guard let url = URL(string: urlAPI) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    //MARK: - fetch image method
    func fetchImage(from urlString: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
