//
//  WeatherDetailsCoordinator.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 6/1/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

final class WeatherDetailsCoordinator {
    let viewController: WeatherDetailsViewController
    let interactor: WeatherDetailsInteractor
    
    init(viewController: WeatherDetailsViewController) {
        self.viewController = viewController
        interactor = WeatherDetailsInteractor()
        let presenter = WeatherDetailsPresenter()
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.observer = self
    }
}

extension WeatherDetailsCoordinator: WeatherDetailsObserver {
    func updateViewModel(viewModel: WeatherDetailsViewModel?, error: WeatherErrors?) {
        viewController.viewModel = viewModel
    }
    
}
