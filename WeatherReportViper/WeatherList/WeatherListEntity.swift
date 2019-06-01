//
//  WeatherListEntity.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 5/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

struct WeatherListViewModel {
    let weatherList: [WeatherData]
}

struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let clouds: Clouds
    let name: String

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
    struct Main: Decodable {
        let temp: Double
    }
    
    struct Weather: Decodable {
        let icon: String
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
}


