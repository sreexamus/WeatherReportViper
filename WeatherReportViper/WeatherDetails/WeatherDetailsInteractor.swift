//
//  WeatherDetailsInteractor.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 6/1/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

protocol WeatherDetailsInteractorDelegate {
    func showWeatherDetails()
}

protocol WeatherDetailsObserver {
    func updateViewModel(viewModel: WeatherDetailsViewModel?, error: WeatherErrors?)
}

final class WeatherDetailsInteractor: WeatherDetailsInteractorDelegate {
    var weatherData: WeatherData?
    var observer: WeatherDetailsObserver?
    
    func showWeatherDetails() {
        
        guard let speed = weatherData?.wind.speed, let degree = weatherData?.wind.deg, let clouds = weatherData?.clouds else {
            return
        }
        let viewModel: WeatherDetailsViewModel = WeatherDetailsViewModel(details: WeatherDetails(speed: String(speed), degree: String(degree), clouds: String(clouds.all)))
        observer?.updateViewModel(viewModel: viewModel, error: nil)
    }
}
