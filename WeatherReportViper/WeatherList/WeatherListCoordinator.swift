//
//  WeatherListCoordinator.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import Foundation

final class WeatherListCoordinator {
    let viewController: WeatherListViewController
    let weatherListInteractor: WeatherListInteractor
    
    init(viewController: WeatherListViewController) {
        self.viewController = viewController
        let interactor = WeatherListInteractor()
        let router = WeatherListRouter()
        let presenter = WeatherLisPresenter()
        weatherListInteractor = interactor
        weatherListInteractor.router = router
        presenter.interactor = interactor
        self.viewController.presenter = presenter
        interactor.observer = self
        router.weatherListViewController = viewController
    }
}

extension WeatherListCoordinator: WeatherListInteractorObserver {
    func updateWithViewModel(viewModel: WeatherListViewModel) {
        viewController.viewModel = viewModel
    }
}
