//
//  WeatherListViewController.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit
import SDWebImage

final class WeatherListViewController: UIViewController {

    private var weatherTableView: UITableView!
    var presenter: WeatherLisPresenter?
    
    var viewModel: WeatherListViewModel? {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        weatherTableView.backgroundColor = .green
        presenter?.fetchWeatherList()
    }
    
    private func setupTableView() {
        weatherTableView = UITableView(frame: .zero, style: .plain)
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        view.addEdgeConstrained(subview: weatherTableView)
        let tableCelnib = UINib(nibName: "WeatherListTableViewCell", bundle: nil)
        weatherTableView.register(tableCelnib, forCellReuseIdentifier: "WeatherListCell")
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.weatherList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as! WeatherListTableViewCell
        
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        cell.updateView(name: viewModel.weatherList[indexPath.row].name, iconImage: viewModel.weatherList[indexPath.row].weather[0].icon, temperature: viewModel.weatherList[indexPath.row].main.temp)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedWeatherData = viewModel?.weatherList[indexPath.row] else { return }
        presenter?.navigateToNextScreen(weatherData: selectedWeatherData)
    }
}
