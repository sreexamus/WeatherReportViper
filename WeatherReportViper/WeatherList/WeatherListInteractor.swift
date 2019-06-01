//
//  WeatherListInteractor.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

protocol WeatherListInteractorObserver {
    func updateWithViewModel(viewModel: WeatherListViewModel)
}

protocol WeatherListInteractorDelegate {
    func fetchWeatherList()
    func navigateToNextScreen(weatherData: WeatherData)
}

final class WeatherListInteractor: WeatherListInteractorDelegate {
    var observer: WeatherListInteractorObserver?
    var router: WeatherListRouterDelegate?
    
    func fetchWeatherList() {
        let service = WeatherListService()
        service.locationUpdatedelegate = self
        service.fetchAllData { [weak self] weatherListViewModel in
            self?.observer?.updateWithViewModel(viewModel: weatherListViewModel!)
        }
    }
    
    func navigateToNextScreen(weatherData: WeatherData) {
        router?.navigateToWeatherDetails(weatherData: weatherData)
    }
}

extension WeatherListInteractor: CurrentLocationWeatherUpdateDelegate {
    func updateViewModel(weatherListViewModel: WeatherListViewModel) {
        observer?.updateWithViewModel(viewModel: weatherListViewModel)
    }
}
