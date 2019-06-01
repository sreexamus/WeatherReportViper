//
//  WeatherDetailsPresenter.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 6/1/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

protocol WeatherDetailsPresenterDelegate {
    func showWeatherDetails()
}

final class WeatherDetailsPresenter: WeatherDetailsPresenterDelegate {
    var interactor : WeatherDetailsInteractorDelegate?
    func showWeatherDetails() {
        interactor?.showWeatherDetails()
    }
}
