//
//  WeatherListRouter.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

protocol WeatherListRouterDelegate {
  func navigateToWeatherDetails(weatherData: WeatherData)
}

final class WeatherListRouter: WeatherListRouterDelegate {
    weak var weatherListViewController: WeatherListViewController?
    func navigateToWeatherDetails(weatherData: WeatherData) {
        let vcDetails = WeatherDetailsViewController()
        let coordinator = WeatherDetailsCoordinator(viewController: vcDetails)
        coordinator.interactor.weatherData = weatherData
        weatherListViewController?.navigationController?.pushViewController(vcDetails, animated: true)
        
    }
}
