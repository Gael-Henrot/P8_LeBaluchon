//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var destinationCityTemperatureLabel: UILabel!
    @IBOutlet weak var destinationCityWeatherDescription: UILabel!
    @IBOutlet weak var destinationCityWeatherPicture : UIImageView!
    @IBOutlet weak var departureCityNameLabel: UILabel!
    @IBOutlet weak var departureCityTemperatureLabel: UILabel!
    @IBOutlet weak var departureCityWeatherDescription: UILabel!
    @IBOutlet weak var departureCityWeatherPicture : UIImageView!
    
    @IBAction func tappedRefreshButton() {
        refreshWeather()
    }
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshWeather()
    }
    
    /// This method refresh all the weather data (description, picture, etc.) to display.
    private func refreshWeather() {
        
        weatherService.getDepartureWeather(callback: { (success, weatherData) in
            guard success else {
                self.presentAlert()
                return
            }
            if let weatherData = weatherData {
                self.departureCityNameLabel.text = weatherData.name
                self.departureCityTemperatureLabel.text = String(weatherData.temperature)
                self.departureCityWeatherDescription.text = weatherData.description
                self.departureCityWeatherPicture.image = UIImage(data: weatherData.picture)
            } else {
                self.presentAlert()
            }
        })
        
        weatherService.getDestinationWeather(callback: { (success, weatherData) in
            guard success else {
                self.presentAlert()
                return
            }
            if let weatherData = weatherData {
                self.destinationCityNameLabel.text = weatherData.name
                self.destinationCityTemperatureLabel.text = String(weatherData.temperature)
                self.destinationCityWeatherDescription.text = weatherData.description
                self.destinationCityWeatherPicture.image = UIImage(data: weatherData.picture)
            } else {
                self.presentAlert()
            }
        })
    }
    
    /// This method presents a standard Alert Controller to warn the user when a problem occurrs during the weather update.
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
