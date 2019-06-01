//
//  WeatherListService.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import MapKit
import Alamofire


enum WeatherResult<T> {
    case success(T)
    case failure(WeatherErrors)
}

enum WeatherErrors {
    case nodata
    case parsingError
    case generic
}

protocol CurrentLocationWeatherUpdateDelegate: class {
    func updateViewModel(weatherListViewModel: WeatherListViewModel)
}

final class WeatherListService {
     var weatherList: [WeatherData] = []
    weak var locationUpdatedelegate: CurrentLocationWeatherUpdateDelegate?
    
    init() {
        let locatioManager = AppLocationManager.shared
        locatioManager.delegate = self
    }
    
    func fetchWeatherList(url: URLConvertible, params: [String: String], completion: @escaping (WeatherResult<WeatherData>)->()){
        Alamofire.request(url, method: .get
            , parameters: params, encoding: URLEncoding.default).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    guard let weatherModel = try? JSONDecoder().decode(WeatherData.self
                        , from: jsonData) else {
                            completion(.failure(.parsingError))
                            return
                    }
                    completion(.success(weatherModel))
                case .failure: completion(.failure(.nodata))
                }
        }
    }
    
    func fetchAllData(completion: @escaping (WeatherListViewModel?) -> ()) {
        
        guard let url = URL(string: Constants.weatherUrl) else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()

            var tokyoData: WeatherResult<WeatherData>?
            var londonData: WeatherResult<WeatherData>?

            dispatchGroup.enter()
            self.fetchWeatherList(url: url, params: ["q" : "London","appid": Constants.APIKey], completion: { result in
                tokyoData = result
                dispatchGroup.leave()
            })

            dispatchGroup.enter()
            self.fetchWeatherList(url: url, params: ["zip" : "94040,us","appid": Constants.APIKey], completion: { result in
                londonData = result
                dispatchGroup.leave()
            })

            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                guard case .success? = tokyoData, case .success? = londonData else { return }

                if case .success(let londonWeather)? = londonData {
                    self.weatherList.append(londonWeather)
                }

                if case .success(let tokyoWeather)? = tokyoData {
                    self.weatherList.append(tokyoWeather)
                }

                completion(WeatherListViewModel(weatherList: self.weatherList))
            })

        }
    }
}


extension WeatherListService: AppLocationManagerDelegate {
    func updateLocation(location: CLLocationCoordinate2D?) {
        print("%%%%%%%%%%%%%%%%%")
        
        print(location?.latitude.description)
        print(location?.longitude.description)
        
        guard let url = URL(string: Constants.weatherUrl), let lat = location?.latitude.description, let lon = location?.longitude.description else { return }

        
        self.fetchWeatherList(url: url, params: ["lat" : lat, "lon" : lon,"appid": Constants.APIKey], completion: { [weak self] result in
            if case .success(let currentWeather) = result {
                self?.weatherList.append(currentWeather)
            }
            
            guard let weatherList = self?.weatherList else { return }
            self?.locationUpdatedelegate?.updateViewModel(weatherListViewModel: WeatherListViewModel(weatherList: weatherList))
        })
    }
}
