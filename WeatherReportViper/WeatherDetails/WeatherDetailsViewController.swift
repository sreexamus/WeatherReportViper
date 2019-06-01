//
//  WeatherDetailsViewController.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    var presenter: WeatherDetailsPresenterDelegate?
    private var cloudsView: UILabel!
    private var degreeView: UILabel!
    private var speedView: UILabel!
    
    var viewModel: WeatherDetailsViewModel? {
        didSet {
            updateDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        createViews()
        presenter?.showWeatherDetails()
        
    }
    
    private func createViews() {
        cloudsView = UILabel()
        degreeView = UILabel()
        speedView = UILabel()
        let stackView = UIStackView(arrangedSubviews: [cloudsView, degreeView, speedView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 120)
            ])
        stackView.backgroundColor = .red
    }
    
    private func updateDetails() {
        guard let clouds = viewModel?.details.clouds, let degree = viewModel?.details.degree, let speed = viewModel?.details.speed else {
            return
        }
        
        cloudsView.text = "Clouds:- \(clouds)"
        degreeView.text = "Degree:- \(degree)"
        speedView.text = "Speed:- \(speed)"
    }
}


