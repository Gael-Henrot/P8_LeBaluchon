//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import Foundation

class WeatherService {
    
    //MARK: - Properties
    private static let appIdKey = APIKeys.openweathermapAPIKey
    private static let units = "metric"
    private static let lang = "fr"
    private static let departureCityId = "2973613" // iD for Suze La Rousse
    private static let destinationCityId = "5128581" // iD for New York City
    
    private static let departureUrlString = "http://api.openweathermap.org/data/2.5/weather?id=\(departureCityId)&appid=\(appIdKey)&units=\(units)&lang=\(lang)"
    private let departureUrl = URL(string: departureUrlString)!
    
    private static let destinationUrlString = "http://api.openweathermap.org/data/2.5/weather?id=\(destinationCityId)&appid=\(appIdKey)&units=\(units)&lang=\(lang)"
    private let destinationUrl = URL(string: destinationUrlString)!
    
    var departureSession: URLSession
    var departurePictureSession: URLSession
    var destinationSession: URLSession
    var destinationPictureSession: URLSession
    
    //MARK: - Initializers
    init(departureSession: URLSession = URLSession(configuration: .default), departurePictureSession: URLSession = URLSession(configuration: .default), destinationSession: URLSession = URLSession(configuration: .default), destinationPictureSession: URLSession = URLSession(configuration: .default)) {
        self.departureSession = departureSession
        self.departurePictureSession = departurePictureSession
        self.destinationSession = destinationSession
        self.destinationPictureSession = destinationPictureSession
    }
    
    //MARK: - Methods
    /// This method gives the name, the temperature, the description and the picture of the weather of the departure city using the getWeather method.
    func getDepartureWeather(callback: @escaping (Bool, WeatherData?) -> Void) {
        getWeather(weatherSession: departureSession, url: departureUrl, pictureSession: departurePictureSession) { (success, data) in
            callback(success, data)
        }
    }
    
    /// This method gives the name, the temperature, the description and the picture of the weather of the destination city using the getWeather method.
    func getDestinationWeather(callback: @escaping (Bool, WeatherData?) -> Void) {
        getWeather(weatherSession: destinationSession, url: destinationUrl, pictureSession: destinationPictureSession) { (success, data) in
            callback(success, data)
        }
    }
    
    /// This method provides the name, the temperature, the description and the picture of the weather of a city using the Openweathermap API (the url parameter determines the city).
    private func getWeather(weatherSession: URLSession, url: URL, pictureSession: URLSession, callback: @escaping (Bool, WeatherData?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = weatherSession.dataTask(with: request) { (data, response, error) in
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
                
                let name = responseJSON.name
                let description = responseJSON.weather.first!.description.firstUppercased
                let icon = responseJSON.weather.first!.icon
                
                let temperature = round(responseJSON.main.temp * 10) / 10
                self.getPicture(session: pictureSession, iconId: icon) { data in
                    guard let data = data else {
                        callback(false, nil)
                        return
                    }
                    let weatherData = WeatherData(name: name, description: description, temperature: temperature, picture: data)
                callback(true, weatherData)
                }
            }
        }
        task.resume()
    }
    
    ///This method gives the picture of the weather according to the iconId parameter provides by the Openweathermap API.
    private func getPicture(session: URLSession, iconId: String, completionHandler: @escaping (Data?) -> Void) {
        let pictureURLString = "http://openweathermap.org/img/wn/\(iconId)@2x.png"
        let task = session.dataTask(with: URL(string: pictureURLString)!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        }
        task.resume()
    }
}
