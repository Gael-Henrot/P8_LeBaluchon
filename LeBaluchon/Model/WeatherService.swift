//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import Foundation

class WeatherService {
    private static let appIdKey = APIKeys().openweathermapAPIKey
    private static let units = "metric"
    private static let lang = "fr"
    private static let departureCityId = "2973613" // iD for Suze La Rousse
    private static let destinationCityId = "5128581" // iD for New York City
    
    private static let departureUrlString = "http://api.openweathermap.org/data/2.5/weather?id=\(departureCityId)&appid=\(appIdKey)&units=\(units)&lang=\(lang)"
    private static let departureUrl = URL(string: departureUrlString)
    
    private static let destinationUrlString = "http://api.openweathermap.org/data/2.5/weather?id=\(destinationCityId)&appid=\(appIdKey)&units=\(units)&lang=\(lang)"
    private static let destinationUrl = URL(string: destinationUrlString)
    
    private var departureSession: URLSession = URLSession(configuration: .default)
    private var destinationSession: URLSession = URLSession(configuration: .default)
    
    
    func getDepartureWeather(callback: @escaping (Bool, WeatherData?) -> Void) {
        var request = URLRequest(url: WeatherService.destinationUrl!)
        request.httpMethod = "GET"
        
        let task = departureSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherDataModel.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                
                guard let description = responseJSON.weather.first?.description else {
                    callback(false, nil)
                    return
                }
                guard let icon = responseJSON.weather.first?.icon else {
                    callback(false, nil)
                    return
                }
                let temperature = responseJSON.main.temp
                
                let departureData = WeatherData(description: description, temperature: temperature, iconId: icon)
                callback(true, departureData)
                
            }
        }
        task.resume()
        
    }
    
    func getDestinationWeather() {
        
    }
}
