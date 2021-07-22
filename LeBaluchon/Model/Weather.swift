//
//  Weather.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import Foundation

struct WeatherDataModel: Decodable {
    var weather: [Weather]
    var main: Main
}


struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    
    enum CodingKeys: String , CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct WeatherData {
    var description: String
    var temperature : Double
    var iconId: String
}


/*
 
 {
     "coord": {
         "lon": 4.8435,
         "lat": 44.2879
     },
     "weather": [
         {
             "id": 800,
             "main": "Clear",
             "description": "ciel dégagé",
             "icon": "01d"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 33.46,
         "feels_like": 32.28,
         "temp_min": 30.89,
         "temp_max": 34.68,
         "pressure": 1017,
         "humidity": 28
     },
     "visibility": 10000,
     "wind": {
         "speed": 3.09,
         "deg": 330
     },
     "clouds": {
         "all": 0
     },
     "dt": 1626954768,
     "sys": {
         "type": 1,
         "id": 6516,
         "country": "FR",
         "sunrise": 1626927436,
         "sunset": 1626981392
     },
     "timezone": 7200,
     "id": 2973613,
     "name": "Suze-la-Rousse",
     "cod": 200
 }
 
 */
