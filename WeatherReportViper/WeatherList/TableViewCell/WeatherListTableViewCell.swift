//
//  WeatherListTableViewCell.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

final class WeatherListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var placeName: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var temperature: UILabel!
    
    func updateView(name: String, iconImage: String, temperature: Double) {
        icon.sd_setImage(with: URL(string: Constants.imageUrl+iconImage+".png"), completed: nil)
        self.temperature.text = "Temperature: \(temperature)"
        placeName.text = name
    }
}
