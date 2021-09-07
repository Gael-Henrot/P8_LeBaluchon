//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var destinationCityTemperatureLabel: UILabel!
    @IBOutlet weak var destinationCityWeatherDescription: UILabel!
    @IBOutlet weak var destinationCityWeatherPicture : UIImageView!
    @IBOutlet weak var departureCityNameLabel: UILabel!
    @IBOutlet weak var departureCityTemperatureLabel: UILabel!
    @IBOutlet weak var departureCityWeatherDescription: UILabel!
    @IBOutlet weak var departureCityWeatherPicture : UIImageView!
    @IBOutlet weak var destinationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var departureActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var destinationStackView: UIStackView!
    @IBOutlet weak var departureStackView: UIStackView!
    
    //MARK: - Methods
    
    @IBAction func tappedRefreshButton() {
        refreshWeather()
    }
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshWeather()
    }
    
    /// This method refreshes all the weather data (description, picture, etc.) to display and manages the display during loading.
    private func refreshWeather() {
        self.toggleActivityIndicator(location: .departure, show: true)
        self.toggleActivityIndicator(location: .destination, show: true)
        
        weatherService.getDepartureWeather(callback: { [weak self] (success, weatherData) in
            guard let self = self else { return }
            guard success else {
                self.presentErrorAlert(message: "The weather download failed.")
                return
            }
            if let weatherData = weatherData {
                self.departureCityNameLabel.text = weatherData.name
                self.departureCityTemperatureLabel.text = String(weatherData.temperature)
                self.departureCityWeatherDescription.text = weatherData.description
                self.departureCityWeatherPicture.image = UIImage(data: weatherData.picture)
                self.toggleActivityIndicator(location: .departure, show: false)
            } else {
                self.presentErrorAlert(message: "The weather download failed.")
            }
        })
        
        weatherService.getDestinationWeather(callback: { [weak self] (success, weatherData) in
            guard let self = self else { return }
            guard success else {
                self.presentErrorAlert(message: "The weather download failed.")
                return
            }
            if let weatherData = weatherData {
                self.destinationCityNameLabel.text = weatherData.name
                self.destinationCityTemperatureLabel.text = String(weatherData.temperature)
                self.destinationCityWeatherDescription.text = weatherData.description
                self.destinationCityWeatherPicture.image = UIImage(data: weatherData.picture)
                self.toggleActivityIndicator(location: .destination, show: false)
            } else {
                self.presentErrorAlert(message: "The weather download failed.")
            }
        })
    }
    
    private enum Location {
        case departure, destination
    }
    
    /// This method hides or shows the description stackview, the picture or the activity indicator according to the location.
    private func toggleActivityIndicator(location: Location, show: Bool) {
        switch location {
        case .departure :
            departureStackView.isHidden = show
            departureCityWeatherPicture.isHidden = show
            departureActivityIndicator.isHidden = !show
            
        case .destination :
            destinationStackView.isHidden = show
            destinationCityWeatherPicture.isHidden = show
            destinationActivityIndicator.isHidden = !show
        }
        
    }
}
