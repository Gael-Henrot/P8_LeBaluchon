//
//  FakeWeatherData.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 23/07/2021.
//

import Foundation

class FakeWeatherData {
    static let responseOK = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://api.openweathermap.org/data/2.5/")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    
    class WeatherError: Error {}
    static let error = WeatherError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherData.self)
        let url = bundle.url(forResource: "WeatherData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var IncorrectWeatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherData.self)
        let url = bundle.url(forResource: "IncorrectWeatherData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    static let pictureData = "picture".data(using: .utf8)!
}
