//
//  WeatherLisPresenter.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

protocol WeatherLisPresenterDelegate {
    func fetchWeatherList()
    func navigateToNextScreen(weatherData: WeatherData)
}

final class WeatherLisPresenter: WeatherLisPresenterDelegate {

    var interactor: WeatherListInteractorDelegate?
    
    func fetchWeatherList() {
        interactor?.fetchWeatherList()
    }
    
    func navigateToNextScreen(weatherData: WeatherData) {
        interactor?.navigateToNextScreen(weatherData: weatherData)
    }
    
}
